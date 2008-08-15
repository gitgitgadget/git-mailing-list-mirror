From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: Re: [PATCH] bash-completion: Add non-command git help files to bash-completion
Date: Fri, 15 Aug 2008 22:32:16 +0200
Message-ID: <B03ECD53-5920-4750-816F-890980C4CBD6@ai.rug.nl>
References: <1218816948-7864-1-git-send-email-marcus@griep.us> <7v8wuyb0m7.fsf@gitster.siamese.dyndns.org> <48A5CC07.2040500@griep.us> <7vvdy29kok.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Marcus Griep <marcus@griep.us>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 22:34:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU5zU-0001ED-Q5
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 22:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761831AbYHOUce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 16:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761819AbYHOUce
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 16:32:34 -0400
Received: from frim.nl ([87.230.85.232]:52658 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761802AbYHOUcc (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Aug 2008 16:32:32 -0400
Received: from s5591931c.adsl.wanadoo.nl ([85.145.147.28] helo=[192.168.1.33])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pdebie@ai.rug.nl>)
	id 1KU5yB-0001tj-Ei; Fri, 15 Aug 2008 22:32:23 +0200
In-Reply-To: <7vvdy29kok.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92516>


On 15 aug 2008, at 20:50, Junio C Hamano wrote:

> That is exactly what I mean.  I do not think bloating shell  
> completion to
> enumerate what help topics there are when the user hits "git help  
> <TAB>"
> is a good idea to begin with.  It is a maintenance nightmere for one
> thing, and it does not help non-bash users.
>
> 	$ git help
> 	$ git help --all
>
> are existing ways for you to get list of "command topics" that you  
> can ask
> the help system about, but I do not see a way to ask "git-help, please
> tell me what topics that are not git-commands can I ask you about?",  
> hence
> my suggestion to add "git help topics".
>
> And if you based "git help <TAB>" completion on the output from such  
> help
> subcommand, you would not have to maintain the list of topics  
> yourself in
> the completion script, and I would not mind such a patch too much.

How about something simple like this?

diff --git a/builtin-help.c b/builtin-help.c
index 391f749..a49b5c2 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -446,6 +446,11 @@ int cmd_help(int argc, const char **argv, const  
char *prefix)
                 return 0;
         }

+       if (!strcmp("man-path", argv[0])) {
+               printf("%s\n", GIT_MAN_PATH);
+               return 0;
+       }
+
         switch (help_format) {
         case HELP_FORMAT_MAN:
                 show_man_page(argv[0]);
diff --git a/contrib/completion/git-completion.bash b/contrib/ 
completion/git-completion.bash
index 3396e35..f781661 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -885,7 +885,8 @@ _git_help ()
                 return
                 ;;
         esac
-       __gitcomp "$(__git_all_commands)"
+       __gitcomp "$(ls $(./git help man-path)/man?/* |
+         sed -n 's/^.*\/git-\{0,1\}\(.*\)\.[0-9]$/\1/p')"
  }
