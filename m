From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-p4: fix handling of multi-word P4EDITOR
Date: Thu, 07 May 2015 15:16:23 -0700
Message-ID: <xmqqtwvom3t4.fsf@gitster.dls.corp.google.com>
References: <1431019501-30807-1-git-send-email-luke@diamand.org>
	<1431019501-30807-3-git-send-email-luke@diamand.org>
	<xmqqr3qsp8a0.fsf@gitster.dls.corp.google.com>
	<554BBCBE.1020408@diamand.org>
	<xmqqlhh0nny1.fsf@gitster.dls.corp.google.com>
	<554BCE25.5070308@diamand.org>
	<xmqqa8xgnlme.fsf@gitster.dls.corp.google.com>
	<xmqq3838nl5l.fsf@gitster.dls.corp.google.com>
	<554BE15B.3040303@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Chris Lasell <chrisl@pixar.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Fri May 08 00:16:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqU5n-00068x-Km
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 00:16:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbbEGWQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 18:16:27 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50006 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751021AbbEGWQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 18:16:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B89A4506EB;
	Thu,  7 May 2015 18:16:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fLJJD3EqlvSW9zgaLKWV5M7g3es=; b=ECWvKM
	q71wK/lSBXP0jqT2GlVN2spNbuhhFLFAPv3LKxNh8jh8PCQOH2zmzIFidqIQATdI
	/Kp+wzYiY1FiplyrdtR/Fd/MJYq4O7lpZLemXfMIFsKAP7imcdqCS8+Z7qLukumN
	ZiBgyR/3KS0FZKNAq166/jd4/8mw75ULHisuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AEVp7Qz+1zW5Mjurbr/5oqsAvddyxwHt
	J0lpczPykJryhG6fJ5Zs3lv0EpJQ/a6NWyKcI3O/cOwuB+0rpINc2BWKznVwK/WW
	lrtxL1x21hUto4vp3ZhjKO5qawQl+xrtoJqwnIcrsfbXkyP2rPC3NXMhw7yjRoG9
	fR3lTtay9/I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B151D506EA;
	Thu,  7 May 2015 18:16:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23EB2506E9;
	Thu,  7 May 2015 18:16:24 -0400 (EDT)
In-Reply-To: <554BE15B.3040303@diamand.org> (Luke Diamand's message of "Thu,
	07 May 2015 23:04:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B284DF5C-F506-11E4-8227-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268593>

Luke Diamand <luke@diamand.org> writes:

> On 07/05/15 22:16, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>> i.e. the shell at the beginning of system sees "$customEditor"
>> (including the double quotes) as a quoted variable, expand the
>> environment variable as exported, and treat it as the path to
>> the program.  Again untested but I think
>>
>> 	P4EDITOR="\"\$customEditor\"" &&
>
> Or will this work?
>
> -	P4EDITOR="$TRASH_DIRECTORY/ed.sh" &&
> +	P4EDITOR="\"$TRASH_DIRECTORY/ed.sh\"" &&

I wasn't sure TRASH_DIRECTORY was exported; as long as it is (and it
seems to be, from lib-test-functions.sh), that should be sufficient.

> I'm still a bit worried about what will happen to Windows users with
> this change though. I think the following avoids breaking Windows
> clients,...
>
> -	system([editor, template_file])
> +       system(shlex.split(editor) + [template_file])
>
> I've not tested it on anything other than Linux so far, so best not to
> merge yet!

Looking at run-command.c, GIT_WINDOES_NATIVE and POSIX seems to use
pretty much the same construct, except that they use SHELL_PATH
instead of "sh".

So something like this may be sufficient, perhaps?

 Makefile  | 1 +
 git-p4.py | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 20058f1..fda44bf 100644
--- a/Makefile
+++ b/Makefile
@@ -1776,6 +1776,7 @@ $(SCRIPT_PYTHON_GEN): GIT-CFLAGS GIT-PREFIX GIT-PYTHON-VARS
 $(SCRIPT_PYTHON_GEN): % : %.py
 	$(QUIET_GEN)$(RM) $@ $@+ && \
 	sed -e '1s|#!.*python|#!$(PYTHON_PATH_SQ)|' \
+	    -e 's|SHELL_PATH|$(SHELL_PATH_SQ)|g' \
 	    $< >$@+ && \
 	chmod +x $@+ && \
 	mv $@+ $@
diff --git a/git-p4.py b/git-p4.py
index de06046..eb6d4b1 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1220,7 +1220,7 @@ class P4Submit(Command, P4UserMap):
             editor = os.environ.get("P4EDITOR")
         else:
             editor = read_pipe("git var GIT_EDITOR").strip()
-        system(["sh", "-c", ('%s "$@"' % editor), editor, template_file])
+        system(['''SHELL_PATH''', "-c", ('%s "$@"' % editor), editor, template_file])
 
         # If the file was not saved, prompt to see if this patch should
         # be skipped.  But skip this verification step if configured so.
