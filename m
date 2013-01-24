From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH] mergetool: clean up temp files when aborted
Date: Thu, 24 Jan 2013 16:16:27 -0500
Message-ID: <CABURp0qxj0HVHbYOR1Enfx_A1-ALPDGhLriGp=gab-LBigwt8g@mail.gmail.com>
References: <1359051829-21331-1-git-send-email-hordp@cisco.com> <7vbocebblo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Phil Hord <hordp@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Theodore Ts'o" <tytso@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 22:22:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyUG2-0004Kb-5K
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 22:22:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945965Ab3AXVWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 16:22:24 -0500
Received: from mail-vc0-f180.google.com ([209.85.220.180]:55065 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945980Ab3AXVWS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 16:22:18 -0500
Received: by mail-vc0-f180.google.com with SMTP id fo13so4210378vcb.39
        for <git@vger.kernel.org>; Thu, 24 Jan 2013 13:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ZourVZ4LeqiHYP/J+jnL06pAvzR1S0XDigVgLkPlTlg=;
        b=h7oWP2mS88f9HqY2BfG/EYM7Pfqqt0KCySvda9g94maNpqTpVJ6buO+Bz4ux38tIAt
         buFswmc2MokCWlkPIDCn908gY/ubHtdx42+HykMy/EbHqDf7Mnc1206vFPM4kWP41yK2
         x42Kf0y8O5n4dnAXUkIYKyi5G8ejisOOpLhgwW12dhlvmwvPAo/rXXCR7aQsQLO3VcKy
         7/lWm/1fxe69R+eU7L6qyf7b4g8v8c1JwKibPl/bgaNIduUSojwLes6EtkNv8j6bBXwH
         fnjwYqG+5krozZe2Ce8wtzSW4qdngmzncjRQII4dvArFBaCZgpAMLX3IbVGlaWWKVfXr
         lPoQ==
X-Received: by 10.220.39.69 with SMTP id f5mr3595776vce.45.1359062207100; Thu,
 24 Jan 2013 13:16:47 -0800 (PST)
Received: by 10.58.241.203 with HTTP; Thu, 24 Jan 2013 13:16:27 -0800 (PST)
In-Reply-To: <7vbocebblo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214460>

On Thu, Jan 24, 2013 at 2:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Phil Hord <hordp@cisco.com> writes:
>
>> When handling a symlink conflict or a deleted-file conflict, mergetool
>> stops to ask the user what to do. If the user chooses any option besides
>> "(a)bort", then the temporary files which mergetool created in
>> preparation for handling the conflict are removed.  But these temporary
>> files are not removed when the user chooses to abort the operation.
>>
>>     $ git cherry-pick other/branch
>>     error: could not apply 4e43581... Fix foo.c
>>
>>     $ git status --short
>>     DU foo.c
>>
>>     $ git mergetool
>>     Merging:
>>     foo.c
>>
>>     Deleted merge conflict for 'foo.c':
>>       {local}: deleted
>>       {remote}: modified file
>>     Use (m)odified or (d)eleted file, or (a)bort? a
>>     Continue merging other unresolved paths (y/n) ? n
>>
>>     $ git status --short
>>     DU foo.c
>>     ?? foo.c.BACKUP.16929.c
>>     ?? foo.c.BASE.16929.c
>>     ?? foo.c.LOCAL.16929.c
>>     ?? foo.c.REMOTE.16929.c
>>
>> These temporary files should not remain after the mergetool operation is
>> completed.
>
> Aren't there cases where people "abort" so that they can have a
> chance inspect them outside mergetool program?  If there are no such
> cases, then I would agree with your claim "should not remain", but
> the proposed log message does not explay why it is sure that there
> are no such use cases.

You may be right about other people's workflows which I forgot to
consider.  I have noticed a lot of inconsistency in this tool wrt to
mergetool.keepBackup and mergetool.keepTemporaries.  Perhaps this
change should hinge on the latter.

Would you agree with this rephrased statement (accompanied by matching logic)?

    When mergetool.keepTemporaries is false or not set, these temporary files
    should not remain when the mergetool operation is aborted.


Here is the wording from git help config:

      mergetool.keepBackup
           After performing a merge, the original file with conflict
markers can be saved as a file with a .orig extension. If this
variable is set to false then this file
           is not preserved. Defaults to true (i.e. keep the backup files).

       mergetool.keepTemporaries
           When invoking a custom merge tool, git uses a set of
temporary files to pass to the tool. If the tool returns an error and
this variable is set to true, then
           these temporary files will be preserved, otherwise they
will be removed after the tool has exited. Defaults to false.


I have another commit in the works to clean up consistency around the
keepBackup.  I'll re-roll this one at the same time.

Phil
