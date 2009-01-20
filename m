From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: Support diff.color-words config option
Date: Tue, 20 Jan 2009 09:09:38 -0800
Message-ID: <7vskndkip9.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0901200031350.3586@pacific.mpi-cbg.de>
 <200901192017.54163.bss@iguanasuicide.net>
 <200901192145.21115.bss@iguanasuicide.net>
 <alpine.DEB.1.00.0901201058520.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Santi =?utf-8?Q?B?= =?utf-8?Q?=C3=A9jar?= <santi@agolina.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Teemu Likonen <tlikonen@iki.fi>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 18:12:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPK8F-0004ck-QS
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 18:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757774AbZATRJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 12:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757706AbZATRJz
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 12:09:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755612AbZATRJy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 12:09:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E542E92AF9;
	Tue, 20 Jan 2009 12:09:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 30D0B92AF6; Tue,
 20 Jan 2009 12:09:42 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901201058520.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue, 20 Jan 2009 11:02:00 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 26055AC6-E715-11DD-A0DA-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106496>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> @@ -92,6 +93,8 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
>>  	}
>>  	if (!strcmp(var, "diff.external"))
>>  		return git_config_string(&external_diff_cmd_cfg, var, value);
>> +	if (!strcmp(var, "diff.color-words"))
>
> I'd call it diff.wordregex, because that's what it is.

If we want to add a new word-oriented option to diff that is not about
coloring the word differences, is it safe and sane to reuse the same
definition?  That is, "git diff --color-words" would be affected when
diff.wordregex is set to some value, so does any new word-oriented
operation we will add, and the single regex configured would be used as
the default value to define how a word would look like.

I think it makes sense; I do not think of a case offhand where you would
want to define what a word is for the purpose of coloring diffs in one
way, and would want to use a different definition for another
word-oriented operation.

>> @@ -1550,6 +1553,8 @@ static void builtin_diff(const char *name_a,
>>  				o->word_regex = userdiff_word_regex(one);
>>  			if (!o->word_regex)
>>  				o->word_regex = userdiff_word_regex(two);
>> +			if (!o->word_regex)
>> +				o->word_regex = diff_color_words_cfg;
>
> IMHO this is the wrong order.  config should not override attributes, 
> which are by definition more specific.

Isn't it merely giving a fallback value when attributes does not give one?

By the way, wouldn't it make sense to optimize the precontext of that hunk
by doing _something_ like:

	if (!o->word_regex && strcmp(one->path, two->path))
        	o->word_regex = userdiff_word_regex(two);

"Something like" comes from special cases like /dev/null for new/deleted
files, etc.
