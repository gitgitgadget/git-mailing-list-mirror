From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/9] Refactor excluded and path_excluded
Date: Tue, 04 Sep 2012 10:23:02 -0700
Message-ID: <7vr4qhbt3d.fsf@alter.siamese.dyndns.org>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
 <1346544731-938-6-git-send-email-git@adamspiers.org>
 <CACsJy8A-P0RziZt1_PajFrzqmq9ZbkyaxwUCeDAO3XteQ0gAag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Adam Spiers <git@adamspiers.org>, git list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 19:23:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8wqI-0008UA-N3
	for gcvg-git-2@plane.gmane.org; Tue, 04 Sep 2012 19:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532Ab2IDRXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Sep 2012 13:23:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58486 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757459Ab2IDRXF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2012 13:23:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8295480CB;
	Tue,  4 Sep 2012 13:23:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FVcdMFaySxAAMRpZWFxWSOZN/ZI=; b=j7FSxv
	zQOdm7ifkyNG0a/21xD2uaWO9SxQGLUhAFTa4+054lxWyILjDgqBfym/BIWRB3bb
	GqvlFPBFkPMH43IS07N6LTcrwMJq+ZlMCsGxKRFNQstNv+V+e7VICIwrTY6TPIQu
	jkWjIjsaGUSlKujB53zNPapY6nOXAi7HsxW5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZhpQ0Is2BFHLKLwuhUoepe0O4zNCSNtF
	sW8CohfBmaHLmaSzcT3AdiDkGlhwN7B1NmzLWsMFBmAEOyY5vjN7D3k2wq9GxaNr
	xm7+s6zxAUKGvF2u5ouIwnd1Lo0jY8XkUtpyCdD9LoVa4wOliYM+VOFg46TAdqqy
	YgVRnbk4POE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F38080CA;
	Tue,  4 Sep 2012 13:23:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C7F7780C9; Tue,  4 Sep 2012
 13:23:03 -0400 (EDT)
In-Reply-To: <CACsJy8A-P0RziZt1_PajFrzqmq9ZbkyaxwUCeDAO3XteQ0gAag@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 4 Sep 2012 19:40:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F2497D0-F6B5-11E1-A0A6-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204754>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sun, Sep 2, 2012 at 7:12 AM, Adam Spiers <git@adamspiers.org> wrote:
>>  extern void path_exclude_check_init(struct path_exclude_check *, struct dir_struct *);
>>  extern void path_exclude_check_clear(struct path_exclude_check *);
>> +extern struct exclude *path_excluded_1(struct path_exclude_check *, const char *,
>> +                                      int namelen, int *dtype);
>>  extern int path_excluded(struct path_exclude_check *, const char *, int namelen, int *dtype);
>
> Exported functions should have nicer names than *_1. No idea what are
> better names though, maybe exclude_path?

Which part is better?

Just like between path_excluded_1() and path_excluded() nobody can
tell how they differ (except perhaps the former smells more special
purpose thanks to its funny name) and wouldn't be able to tell which
one to call without looking at their sources, it is hard to tell
path_excluded() and exclude_path() apart.  In a sense, that pair is
even worse as there is no hint to suggest which one is more exotic
between them in their names.
