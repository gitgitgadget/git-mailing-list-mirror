From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH] Git-p4: git-p4.changeOnSubmit to do 'change' instead
 of 'submit'.
Date: Sat, 15 Oct 2011 21:10:58 +0100
Message-ID: <4E99E8D2.6020107@diamand.org>
References: <1318629110-15232-1-git-send-email-andreiw@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, Pete Wyckoff <pw@padd.com>
To: Andrei Warkentin <andreiw@vmware.com>
X-From: git-owner@vger.kernel.org Sat Oct 15 22:11:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFAZX-0004nd-UE
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 22:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053Ab1JOULC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 16:11:02 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40606 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751882Ab1JOULB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 16:11:01 -0400
Received: by wyg36 with SMTP id 36so1071701wyg.19
        for <git@vger.kernel.org>; Sat, 15 Oct 2011 13:11:00 -0700 (PDT)
Received: by 10.216.4.209 with SMTP id 59mr1775972wej.47.1318709459859;
        Sat, 15 Oct 2011 13:10:59 -0700 (PDT)
Received: from [86.26.7.206] (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id n21sm21685272wbp.2.2011.10.15.13.10.58
        (version=SSLv3 cipher=OTHER);
        Sat, 15 Oct 2011 13:10:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <1318629110-15232-1-git-send-email-andreiw@vmware.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183674>

On 14/10/11 22:51, Andrei Warkentin wrote:
> Many users of p4/sd use changelists for review, regression
> tests and batch builds, thus changes are almost never directly
> submitted.
>
> This new config option lets a 'p4 change -i' run instead of
> the 'p4 submit -i'.
>
> Signed-off-by: Andrei Warkentin<andreiw@vmware.com>
> ---
>   contrib/fast-import/git-p4     |   16 ++++++++++++----
>   contrib/fast-import/git-p4.txt |   10 ++++++++++
>   2 files changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 2f7b270..19c295b 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -959,7 +959,10 @@ class P4Submit(Command, P4UserMap):
>                   submitTemplate = message[:message.index(separatorLine)]
>                   if self.isWindows:
>                       submitTemplate = submitTemplate.replace("\r\n", "\n")
> -                p4_write_pipe("submit -i", submitTemplate)
> +                if gitConfig("git-p4.changeOnSubmit"):
> +                    p4_write_pipe("change -i", submitTemplate)
> +                else:
> +                    p4_write_pipe("subadasdmit -i", submitTemplate)


What does "p4 subadasmit" do? That's a new command to me!

(This patch also fails to apply cleanly to my shell-metacharacter patch).

>
>                   if self.preserveUser:
>                       if p4User:
> @@ -981,9 +984,14 @@ class P4Submit(Command, P4UserMap):
>               file = open(fileName, "w+")
>               file.write(self.prepareLogMessage(template, logMessage))
>               file.close()
> -            print ("Perforce submit template written as %s. "
> -                   + "Please review/edit and then use p4 submit -i<  %s to submit directly!"
> -                   % (fileName, fileName))
> +            if gitConfig("git-p4.changeOnSubmit"):
> +                print ("Perforce submit template written as %s. "
> +                       + "Please review/edit and then use p4 change -i<  %s to create changelist!"
> +                       % (fileName, fileName))
> +            else:
> +                print ("Perforce submit template written as %s. "
> +                       + "Please review/edit and then use p4 submit -i<  %s to submit directly!"
> +                       % (fileName, fileName))
>
>       def run(self, args):
>           if len(args) == 0:
> diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.txt
> index 52003ae..3a3a815 100644
> --- a/contrib/fast-import/git-p4.txt
> +++ b/contrib/fast-import/git-p4.txt
> @@ -180,6 +180,16 @@ git-p4.allowSubmit
>
>     git config [--global] git-p4.allowSubmit false
>
> +git-p4.changeOnSubmit
> +
> +  git config [--global] git-p4.changeOnSubmit false
> +
> +Most places using p4/sourcedepot don't actually want you submit

Small typo: should be "want you *to* submit"

> +changes directly, and changelists are used to do regression testing,
> +batch builds and review, hence, by setting this parameter to
> +true you acknowledge you end up creating a changelist which you
> +must then manually commit.
> +
>   git-p4.syncFromOrigin
>
>   A useful setup may be that you have a periodically updated git repository

Regards!
Luke
