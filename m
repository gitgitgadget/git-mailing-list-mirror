From: Andrei Warkentin <awarkentin@vmware.com>
Subject: Re: [PATCH] Git-p4: Add "git p4 change" command.
Date: Mon, 17 Oct 2011 15:21:22 -0700 (PDT)
Message-ID: <1615625330.26778.1318890082820.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
References: <1318889937-17693-1-git-send-email-andreiw@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Andrei Warkentin <andreiw@vmware.com>
X-From: git-owner@vger.kernel.org Tue Oct 18 00:21:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFvYl-0005vz-Hg
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 00:21:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756079Ab1JQWVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Oct 2011 18:21:23 -0400
Received: from smtp-outbound-2.vmware.com ([65.115.85.73]:7797 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754371Ab1JQWVX (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2011 18:21:23 -0400
Received: from mailhost4.vmware.com (mailhost4.vmware.com [10.16.67.124])
	by smtp-outbound-2.vmware.com (Postfix) with ESMTP id 1EF3719002;
	Mon, 17 Oct 2011 15:21:23 -0700 (PDT)
Received: from zimbra-prod-mta-1.vmware.com (zimbra-prod-mta-1.vmware.com [10.113.160.173])
	by mailhost4.vmware.com (Postfix) with ESMTP id 0CC0DCA039;
	Mon, 17 Oct 2011 15:21:23 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra-prod-mta-1.vmware.com (Postfix) with ESMTP id 0011079A7C;
	Mon, 17 Oct 2011 15:21:22 -0700 (PDT)
X-Virus-Scanned: amavisd-new at 
Received: from zimbra-prod-mta-1.vmware.com ([127.0.0.1])
	by localhost (zimbra-prod-mta-1.vmware.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VlN-nwUwF5QZ; Mon, 17 Oct 2011 15:21:22 -0700 (PDT)
Received: from zimbra-prod-mbox-2.vmware.com (zimbra-prod-mbox-2.vmware.com [10.113.160.202])
	by zimbra-prod-mta-1.vmware.com (Postfix) with ESMTP id DA34979A75;
	Mon, 17 Oct 2011 15:21:22 -0700 (PDT)
In-Reply-To: <1318889937-17693-1-git-send-email-andreiw@vmware.com>
X-Originating-IP: [10.113.61.163]
X-Mailer: Zimbra 7.1.1_GA_3225 (ZimbraWebClient - FF3.0 (Linux)/7.1.1_GA_3225)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183834>

----- Original Message -----
> From: "Andrei Warkentin" <andreiw@vmware.com>
> To: git@vger.kernel.org, gitster@pobox.com
> Cc: "Andrei Warkentin" <andreiw@vmware.com>
> Sent: Monday, October 17, 2011 6:18:57 PM
> Subject: [PATCH] Git-p4: Add "git p4 change" command.
> 
> Many users of p4/sd use changelists for review, regression
> tests and batch builds.
> 
> "p4 change" is almost equivalent to "p4 submit", yet will
> just create the changelist and not submit it.
> 
> Signed-off-by: Andrei Warkentin <andreiw@vmware.com>
> ---
>  contrib/fast-import/git-p4 |   23 ++++++++++++++++++-----
>  1 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
> index 2f7b270..dd084b9 100755
> --- a/contrib/fast-import/git-p4
> +++ b/contrib/fast-import/git-p4
> @@ -950,7 +950,10 @@ class P4Submit(Command, P4UserMap):
>              if checkModTime and (os.stat(fileName).st_mtime <=
>              mtime):
>                  response = "x"
>                  while response != "y" and response != "n":
> -                    response = raw_input("Submit template unchanged.
> Submit anyway? [y]es, [n]o (skip this patch) ")
> +                    if (self.cmdname == "change"):
> +                        response = raw_input("Change template
> unchanged. Create changelist anyway? [y]es, [n]o (skip this patch)
> ")
> +                    else:
> +                        response = raw_input("Submit template
> unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
>  
>              if response == "y":
>                  tmpFile = open(fileName, "rb")
> @@ -959,7 +962,10 @@ class P4Submit(Command, P4UserMap):
>                  submitTemplate =
>                  message[:message.index(separatorLine)]
>                  if self.isWindows:
>                      submitTemplate = submitTemplate.replace("\r\n",
>                      "\n")
> -                p4_write_pipe("submit -i", submitTemplate)
> +                if (self.cmdname == "change"):
> +                    p4_write_pipe("change -i", submitTemplate)
> +                else:
> +                    p4_write_pipe("submit -i", submitTemplate)
>  
>                  if self.preserveUser:
>                      if p4User:
> @@ -981,9 +987,14 @@ class P4Submit(Command, P4UserMap):
>              file = open(fileName, "w+")
>              file.write(self.prepareLogMessage(template, logMessage))
>              file.close()
> -            print ("Perforce submit template written as %s. "
> -                   + "Please review/edit and then use p4 submit -i <
> %s to submit directly!"
> -                   % (fileName, fileName))
> +            if (self.cmdname == "change"):
> +                print ("Perforce change template written as %s. "
> +                       + "Please review/edit and then use p4 change
> -i < %s to submit directly!"
> +                       % (fileName, fileName))
> +            else:
> +                print ("Perforce submit template written as %s. "
> +                       + "Please review/edit and then use p4 submit
> -i < %s to submit directly!"
> +                       % (fileName, fileName))
>  
>      def run(self, args):
>          if len(args) == 0:
> @@ -2177,6 +2188,7 @@ commands = {
>      "debug" : P4Debug,
>      "submit" : P4Submit,
>      "commit" : P4Submit,
> +    "change" : P4Submit,
>      "sync" : P4Sync,
>      "rebase" : P4Rebase,
>      "clone" : P4Clone,
> @@ -2202,6 +2214,7 @@ def main():
>          sys.exit(2)
>  
>      options = cmd.options
> +    cmd.cmdname = cmdName
>      cmd.gitdir = os.environ.get("GIT_DIR", None)
>  
>      args = sys.argv[2:]
> --
> 1.7.4.1
> 

This is the change I would like to have reviewed.

Sorry again for the spam.

A
