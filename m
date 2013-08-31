From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] revision: introduce --exclude=<glob> to tame wildcards
Date: Fri, 30 Aug 2013 17:29:44 -0700
Message-ID: <xmqqwqn2wvlz.fsf@gitster.dls.corp.google.com>
References: <1377838805-7693-1-git-send-email-felipe.contreras@gmail.com>
	<7vhae7k7t1.fsf@alter.siamese.dyndns.org>
	<CAMP44s1y2kvSnF3dKDMr9QtS40PNSW93DWCxFUoL658YkqYeVA@mail.gmail.com>
	<CAPc5daVSqoE74kmsobg7RpMtiL3vzKN+ckAcWEKU_Q_wF8HYuA@mail.gmail.com>
	<CAMP44s0P=XF5C8+fU2cJ-Xuq57iqcAn674Upub6N=+iiMpQK0g@mail.gmail.com>
	<xmqqeh9b15x6.fsf@gitster.dls.corp.google.com>
	<xmqq1u5aybri.fsf_-_@gitster.dls.corp.google.com>
	<CACsJy8DOx8Q5kLizfeP2AgDaD8+EDsQL9xtOGphrmgG=dAabcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 02:29:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFZ4a-0007Um-GS
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 02:29:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755125Ab3HaA3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 20:29:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32945 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752991Ab3HaA3s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 20:29:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 614843DE66;
	Sat, 31 Aug 2013 00:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YcNd7BhSxfTDBMm5JCWdJgUHCT4=; b=ExKma1
	J1tTXa2fQDgc+BB82KD+VDRLsh8/WILwE34mXBVO5VHbJ94ILWMVnokvAMJYiURe
	M2dWBO0HcQGAw9lDAZB30cVvM4hImvH50rfmbp4++l5HxrzYhtN2bAiJHqETlOBZ
	y+XX5hHt+gUerptmVkgmA4dzsondV/u+m2B+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bXL1TyPH9kQA4YxUsi89AVlC1AHmjvqo
	62zzcIAK/5K4hhPAalz8JVy9avAP9A3mMU4bsNr/G0kfkG7jBdeqnZtEffInO7wu
	w76/rw6aIMzi775yZF2tw1Z6GfRH+aRTaO7Bl5UKEhpgHO+B1WevdIKctbV1xdmD
	AeIkk7y0hHg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DCBA3DE65;
	Sat, 31 Aug 2013 00:29:47 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 555943DE63;
	Sat, 31 Aug 2013 00:29:46 +0000 (UTC)
In-Reply-To: <CACsJy8DOx8Q5kLizfeP2AgDaD8+EDsQL9xtOGphrmgG=dAabcQ@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 31 Aug 2013 07:22:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 70270520-11D4-11E3-B669-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233487>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Aug 31, 2013 at 6:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> +static int ref_excluded(struct rev_info *revs, const char *path)
>> +{
>> +       struct string_list_item *item;
>> +
>> +       if (!revs->ref_excludes)
>> +               return 0;
>> +       for_each_string_list_item(item, revs->ref_excludes) {
>> +               if (!fnmatch(item->string, path, 0))
>> +                       return 1;
>> +       }
>> +       return 0;
>> +}
>
> If you pursue this, please use wildmatch instead so it supports "foo/**".

The thought crossed my mind and I think we should match what the
existing --glob=<pattern> option does.  A cursory look in
refs.c::filter_refs() used by refs.c::for_each_glob_ref_in() tells
me that we are using fnmatch without FNM_PATHNAME, so that is what
the above part does.
