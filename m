From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v2] git-rebase--interactive.sh: add config option for
 custom instruction format
Date: Tue, 9 Jun 2015 15:38:54 -0400
Message-ID: <CANoM8SVXmYJn7wbxcPuBSUa-X8v0nggpv_vC8LtPgaBwMtP0HQ@mail.gmail.com>
References: <1433797202-97425-1-git-send-email-rappazzo@gmail.com>
 <1433797202-97425-2-git-send-email-rappazzo@gmail.com> <9a61f06b14f58a0bd2b687e2aef2b805@www.dscho.org>
 <xmqqmw0865zk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 21:39:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2PMn-0001NS-CH
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 21:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753738AbbFITjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 15:39:16 -0400
Received: from mail-ob0-f196.google.com ([209.85.214.196]:34826 "EHLO
	mail-ob0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932161AbbFITjP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 15:39:15 -0400
Received: by obbnt9 with SMTP id nt9so3205780obb.2
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 12:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=mNUS3Jy2fNzIfoOiAbeP3bhmw9VZaGQWvOvvK4IOTxI=;
        b=FDLxWJ+rLUy5oYoMGGb80vBKIz9asOQtOQsabq00BprIgUIglpCci0Dk5lKFu7CWU8
         YxsU6PjqeWtrZHMIPlT9xqSLTSgH+Y+3WJ82CFeHDssNCfMVc+hBgKyl6iab2y5zQY3L
         MtR0aYPEZ27OugpI+vZuoCn0YAsLUx4qWcB6r36Se/Ix624zcKxPswCjFEVvvjhkIt2n
         ppCzLVY4g2O1nIayd9snha/0xC8DRjzlZ66F0KGuHZMAGj50bnV7yrvNEy3NOey4qmiE
         DKk4Or5sb0m79q+lulrB6vJda64LRvYJZ5jf9kmDkFqIqukOJIco8wXdzzlIqhpKgvm9
         cdAQ==
X-Received: by 10.202.212.147 with SMTP id l141mr17474868oig.89.1433878754715;
 Tue, 09 Jun 2015 12:39:14 -0700 (PDT)
Received: by 10.202.204.20 with HTTP; Tue, 9 Jun 2015 12:38:54 -0700 (PDT)
In-Reply-To: <xmqqmw0865zk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271236>

I have since reworked this script to support the short hash in the
custom format as a special case:

-git rev-list $merges_option --pretty=oneline --reverse --left-right
--topo-order \
+format=$(git config --get rebase.instructionFormat)
+no_format=$?
+if test ${no_format} -ne 0
+then
+ format="%H %s"
+elif test "${format:0:3}" != "%H " && test "${format:0:3}" != "%h "
+then
+ format="%H ${format}"
+fi
+# the 'rev-list .. | sed' requires %m to parse; the instruction
requires %H to parse
+git rev-list $merges_option --format="%m${format}" \
+ --reverse --left-right --topo-order \

I also use the $no_format variable later on in the autosquash
re-ordering, and have the tests passing.  I want to add some new tests
on the custom format, and will send a new patch when that is complete.

On Tue, Jun 9, 2015 at 3:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>
>> Besides, are you sure you don't want to substitute an empty
>> rebase.instructionFormat' by '%s'? I would have expected to read
>> ${format:-%s}` (note the colon), but then, this was Junio's
>> suggestion...
>
> That was me simply being sloppy myself, expecting people not to copy
> and paste literally without thinking.  Thanks for noticing.
