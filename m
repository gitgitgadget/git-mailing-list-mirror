From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] fast-export: output reset command for commandline
 revs
Date: Sun, 06 Nov 2011 21:53:32 -0800
Message-ID: <7vr51k32cj.fsf@alter.siamese.dyndns.org>
References: <1320535407-4933-1-git-send-email-srabbelier@gmail.com>
 <1320535407-4933-4-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	"Eric Herman" <eric@freesa.org>,
	"Fernando Vezzosi" <buccia@repnz.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 06:53:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNI9L-0000AH-JX
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 06:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617Ab1KGFxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 00:53:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49923 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752187Ab1KGFxe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 00:53:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27A461C85;
	Mon,  7 Nov 2011 00:53:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p2lN/JdspJDjMatfdvgMjB6T8aM=; b=sA9ADn
	nW38xNV0EQvmzp5QQRbDQd2Im2bR9uAz2GOV20gVjoRjWiMoIJLkKmK7Sis288Tz
	ogxt/whZd99sdiWjH5Q7zr6/dSer+IE+cWjJzYtkpbeLDFbXCfa+uosBgJB4dWzO
	1IOCD/TOQWMyuQEIIacKFNx15xy+v7qDfg2uI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kLk37/aRKdoOho35bjbiCE+ZUSo4zdgr
	xSlFw51Rhl8s6U62/LiqzZo5djWsVBZyB5UPB2DN/cbDTHsSxPqy9SDCNzrEXsYL
	KaD9BwQAY+tLyLHjGtClt8DGcG0XbA7s1h4Unm0adzQclFjJ/kfEOzn5vIqOLauk
	zinI32EWffQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 198F31C84;
	Mon,  7 Nov 2011 00:53:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 683F31C81; Mon,  7 Nov 2011
 00:53:33 -0500 (EST)
In-Reply-To: <1320535407-4933-4-git-send-email-srabbelier@gmail.com> (Sverre
 Rabbelier's message of "Sun, 6 Nov 2011 00:23:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3BC6358-0904-11E1-B31E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184953>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> +static void handle_tags_and_duplicates(struct rev_info *revs, struct string_list *extra_refs)
>  {
>  	int i;
>  
> +	/* even if no commits were exported, we need to export the ref */
> +	for (i = 0; i < revs->cmdline.nr; i++) {
> +		struct rev_cmdline_entry *elem = &revs->cmdline.rev[i];
> +
> +		if (elem->flags & UNINTERESTING)
> +			continue;
> +
> +		if (elem->whence != REV_CMD_REV && elem->whence != REV_CMD_RIGHT)
> +			continue;
> +
> +		char *full_name;
> +		dwim_ref(elem->name, strlen(elem->name), elem->item->sha1, &full_name);

Just a nit I've already fixed locally (iow no need to resend only to fix
this) but this is decl-after-stmt.
