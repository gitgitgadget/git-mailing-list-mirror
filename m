From: Junio C Hamano <gitster@pobox.com>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 19:35:45 -0800
Message-ID: <7v7ik4e4xa.fsf@gitster.siamese.dyndns.org>
References: <200711252248.27904.jnareb@gmail.com>
	<858x4l2apc.fsf@lola.goethe.zz>
	<alpine.LFD.0.99999.0711261417580.9605@xanadu.home>
	<854pf8243i.fsf@lola.goethe.zz>
	<20071126195750.GD25784@efreet.light.src>
	<AA5ECB69-3F77-483E-AD19-04A5515779B3@wincent.com>
	<7vhcj8g0op.fsf@gitster.siamese.dyndns.org>
	<20071127010350.GE14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wincent Colaiuta <win@wincent.com>, Jan Hudec <bulb@ucw.cz>,
	David Kastrup <dak@gnu.org>, Nicolas Pitre <nico@cam.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 04:36:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwrFJ-0005UU-99
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 04:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754112AbXK0DgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 22:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754099AbXK0DgF
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 22:36:05 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:42530 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037AbXK0DgD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2007 22:36:03 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2A4D42EF;
	Mon, 26 Nov 2007 22:36:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 726D19A399;
	Mon, 26 Nov 2007 22:36:11 -0500 (EST)
In-Reply-To: <20071127010350.GE14735@spearce.org> (Shawn O. Pearce's message
	of "Mon, 26 Nov 2007 20:03:50 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66163>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Wincent Colaiuta <win@wincent.com> writes:
>> >
>> > $ git-<tab>
>> > Display all 146 possibilities? (y or n)
>> 
>> The tab completion for bash and zsh would also help you here, but I see
>> there are quite a few commands that should not be there, and it's time
>> to clean it up.
> ...
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index cad842a..1bba68b 100755
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -359,6 +359,15 @@ __git_commands ()
>>  		upload-pack)      : plumbing;;
>>  		write-tree)       : plumbing;;
>>  		verify-tag)       : plumbing;;
>> +		annotate)         : use blame;;
>> +		checkout-index)   : plumbing;;
>> +		diff-stages)      : plumbing;;
>> +		get-tar-commit-id) : plumbing;;
>> +		lost-found)       : deprecated;;
>> +		rebase--interactive) : plumbing;;
>> +		relink)           : obsolete;;
>> +		whatchanged)      : plumbing;;
>> +		verify-pack)      : plumbing;;
>>  		*) echo $i;;
>>  		esac
>>  	done
>
> Ack'd-by: Shawn O. Pearce <spearce@spearce.org>
>
> ;-)

Seriously, speaking I find this "negative" list ugly.  I am wondering if
it makes more sense to use positive "Porcelain" list, or perhaps even
"The most commonly used" list from "git help" output.

Here is an alternate attempt to it.

---

 Documentation/cmd-list.perl            |   59 ++++++++++++------------
 Makefile                               |    2 +-
 contrib/completion/git-completion.bash |   77 ++------------------------------
 generate-cmdlist.sh                    |   34 ++------------
 4 files changed, 40 insertions(+), 132 deletions(-)

diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
index b709551..a966b5e 100755
--- a/Documentation/cmd-list.perl
+++ b/Documentation/cmd-list.perl
@@ -26,10 +26,11 @@ sub format_one {
 	if (!defined $description) {
 		die "No description found in $name.txt";
 	}
+
 	if (my ($verify_name, $text) = ($description =~ /^($name) - (.*)/)) {
 		print $out "gitlink:$name\[1\]::\n\t";
-		if ($attr) {
-			print $out "($attr) ";
+		if ($attr =~ /deprecated/) {
+			print $out "(deprecated) ";
 		}
 		print $out "$text.\n\n";
 	}
@@ -75,27 +76,27 @@ for my $cat (qw(ancillaryinterrogators
 # The following list is sorted with "sort -d" to make it easier
 # to find entry in the resulting git.html manual page.
 __DATA__
-git-add                                 mainporcelain
+git-add                                 mainporcelain common
 git-am                                  mainporcelain
 git-annotate                            ancillaryinterrogators
-git-apply                               plumbingmanipulators
+git-apply                               plumbingmanipulators common
 git-archimport                          foreignscminterface
-git-archive                             mainporcelain
-git-bisect                              mainporcelain
+git-archive                             mainporcelain common
+git-bisect                              mainporcelain common
 git-blame                               ancillaryinterrogators
-git-branch                              mainporcelain
+git-branch                              mainporcelain common
 git-bundle                              mainporcelain
 git-cat-file                            plumbinginterrogators
 git-check-attr                          purehelpers
-git-checkout                            mainporcelain
+git-checkout                            mainporcelain common
 git-checkout-index                      plumbingmanipulators
 git-check-ref-format                    purehelpers
 git-cherry                              ancillaryinterrogators
-git-cherry-pick                         mainporcelain
+git-cherry-pick                         mainporcelain common
 git-citool                              mainporcelain
 git-clean                               mainporcelain
-git-clone                               mainporcelain
-git-commit                              mainporcelain
+git-clone                               mainporcelain common
+git-commit                              mainporcelain common
 git-commit-tree                         plumbingmanipulators
 git-config                              ancillarymanipulators
 git-count-objects                       ancillaryinterrogators
@@ -104,12 +105,12 @@ git-cvsimport                           foreignscminterface
 git-cvsserver                           foreignscminterface
 git-daemon                              synchingrepositories
 git-describe                            mainporcelain
-git-diff                                mainporcelain
+git-diff                                mainporcelain common
 git-diff-files                          plumbinginterrogators
 git-diff-index                          plumbinginterrogators
 git-diff-tree                           plumbinginterrogators
 git-fast-import				ancillarymanipulators
-git-fetch                               mainporcelain
+git-fetch                               mainporcelain common
 git-fetch-pack                          synchingrepositories
 git-filter-branch                       ancillarymanipulators
 git-fmt-merge-msg                       purehelpers
@@ -118,24 +119,24 @@ git-format-patch                        mainporcelain
 git-fsck	                        ancillaryinterrogators
 git-gc                                  mainporcelain
 git-get-tar-commit-id                   ancillaryinterrogators
-git-grep                                mainporcelain
+git-grep                                mainporcelain common
 git-gui                                 mainporcelain
 git-hash-object                         plumbingmanipulators
 git-http-fetch                          synchelpers
 git-http-push                           synchelpers
 git-imap-send                           foreignscminterface
 git-index-pack                          plumbingmanipulators
-git-init                                mainporcelain
+git-init                                mainporcelain common
 git-instaweb                            ancillaryinterrogators
 gitk                                    mainporcelain
-git-log                                 mainporcelain
+git-log                                 mainporcelain common
 git-lost-found                          ancillarymanipulators	deprecated
 git-ls-files                            plumbinginterrogators
 git-ls-remote                           plumbinginterrogators
 git-ls-tree                             plumbinginterrogators
 git-mailinfo                            purehelpers
 git-mailsplit                           purehelpers
-git-merge                               mainporcelain
+git-merge                               mainporcelain common
 git-merge-base                          plumbinginterrogators
 git-merge-file                          plumbingmanipulators
 git-merge-index                         plumbingmanipulators
@@ -144,7 +145,7 @@ git-mergetool                           ancillarymanipulators
 git-merge-tree                          ancillaryinterrogators
 git-mktag                               plumbingmanipulators
 git-mktree                              plumbingmanipulators
-git-mv                                  mainporcelain
+git-mv                                  mainporcelain common
 git-name-rev                            plumbinginterrogators
 git-pack-objects                        plumbingmanipulators
 git-pack-redundant                      plumbinginterrogators
@@ -152,13 +153,13 @@ git-pack-refs                           ancillarymanipulators
 git-parse-remote                        synchelpers
 git-patch-id                            purehelpers
 git-peek-remote                         purehelpers	deprecated
-git-prune                               ancillarymanipulators
+git-prune                               ancillarymanipulators common
 git-prune-packed                        plumbingmanipulators
-git-pull                                mainporcelain
-git-push                                mainporcelain
+git-pull                                mainporcelain common
+git-push                                mainporcelain common
 git-quiltimport                         foreignscminterface
 git-read-tree                           plumbingmanipulators
-git-rebase                              mainporcelain
+git-rebase                              mainporcelain common
 git-receive-pack                        synchelpers
 git-reflog                              ancillarymanipulators
 git-relink                              ancillarymanipulators
@@ -166,28 +167,28 @@ git-remote                              ancillarymanipulators
 git-repack                              ancillarymanipulators
 git-request-pull                        foreignscminterface
 git-rerere                              ancillaryinterrogators
-git-reset                               mainporcelain
-git-revert                              mainporcelain
+git-reset                               mainporcelain common
+git-revert                              mainporcelain common
 git-rev-list                            plumbinginterrogators
 git-rev-parse                           ancillaryinterrogators
-git-rm                                  mainporcelain
+git-rm                                  mainporcelain common
 git-runstatus                           ancillaryinterrogators
 git-send-email                          foreignscminterface
 git-send-pack                           synchingrepositories
 git-shell                               synchelpers
 git-shortlog                            mainporcelain
-git-show                                mainporcelain
-git-show-branch                         ancillaryinterrogators
+git-show                                mainporcelain common
+git-show-branch                         ancillaryinterrogators common
 git-show-index                          plumbinginterrogators
 git-show-ref                            plumbinginterrogators
 git-sh-setup                            purehelpers
 git-stash                               mainporcelain
-git-status                              mainporcelain
+git-status                              mainporcelain common
 git-stripspace                          purehelpers
 git-submodule                           mainporcelain
 git-svn                                 foreignscminterface
 git-symbolic-ref                        plumbingmanipulators
-git-tag                                 mainporcelain
+git-tag                                 mainporcelain common
 git-tar-tree                            plumbinginterrogators	deprecated
 git-unpack-file                         plumbinginterrogators
 git-unpack-objects                      plumbingmanipulators
diff --git a/Makefile b/Makefile
index ccf522a..ca1c2f5 100644
--- a/Makefile
+++ b/Makefile
@@ -804,7 +804,7 @@ git-merge-subtree$X: git-merge-recursive$X
 $(BUILT_INS): git$X
 	$(QUIET_BUILT_IN)$(RM) $@ && ln git$X $@
 
-common-cmds.h: ./generate-cmdlist.sh
+common-cmds.h: ./generate-cmdlist.sh Documentation/cmd-list.perl
 
 common-cmds.h: $(wildcard Documentation/git-*.txt)
 	$(QUIET_GEN)./generate-cmdlist.sh > $@+ && mv $@+ $@
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 599b2fc..d54b415 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -287,79 +287,10 @@ __git_commands ()
 		echo "$__git_commandlist"
 		return
 	fi
-	local i IFS=" "$'\n'
-	for i in $(git help -a|egrep '^ ')
-	do
-		case $i in
-		add--interactive) : plumbing;;
-		applymbox)        : ask gittus;;
-		applypatch)       : ask gittus;;
-		archimport)       : import;;
-		cat-file)         : plumbing;;
-		check-attr)       : plumbing;;
-		check-ref-format) : plumbing;;
-		commit-tree)      : plumbing;;
-		cvsexportcommit)  : export;;
-		cvsimport)        : import;;
-		cvsserver)        : daemon;;
-		daemon)           : daemon;;
-		diff-files)       : plumbing;;
-		diff-index)       : plumbing;;
-		diff-tree)        : plumbing;;
-		fast-import)      : import;;
-		fsck-objects)     : plumbing;;
-		fetch--tool)      : plumbing;;
-		fetch-pack)       : plumbing;;
-		fmt-merge-msg)    : plumbing;;
-		for-each-ref)     : plumbing;;
-		hash-object)      : plumbing;;
-		http-*)           : transport;;
-		index-pack)       : plumbing;;
-		init-db)          : deprecated;;
-		local-fetch)      : plumbing;;
-		mailinfo)         : plumbing;;
-		mailsplit)        : plumbing;;
-		merge-*)          : plumbing;;
-		mktree)           : plumbing;;
-		mktag)            : plumbing;;
-		pack-objects)     : plumbing;;
-		pack-redundant)   : plumbing;;
-		pack-refs)        : plumbing;;
-		parse-remote)     : plumbing;;
-		patch-id)         : plumbing;;
-		peek-remote)      : plumbing;;
-		prune)            : plumbing;;
-		prune-packed)     : plumbing;;
-		quiltimport)      : import;;
-		read-tree)        : plumbing;;
-		receive-pack)     : plumbing;;
-		reflog)           : plumbing;;
-		repo-config)      : plumbing;;
-		rerere)           : plumbing;;
-		rev-list)         : plumbing;;
-		rev-parse)        : plumbing;;
-		runstatus)        : plumbing;;
-		sh-setup)         : internal;;
-		shell)            : daemon;;
-		send-pack)        : plumbing;;
-		show-index)       : plumbing;;
-		ssh-*)            : transport;;
-		stripspace)       : plumbing;;
-		svn)              : import export;;
-		symbolic-ref)     : plumbing;;
-		tar-tree)         : deprecated;;
-		unpack-file)      : plumbing;;
-		unpack-objects)   : plumbing;;
-		update-index)     : plumbing;;
-		update-ref)       : plumbing;;
-		update-server-info) : daemon;;
-		upload-archive)   : plumbing;;
-		upload-pack)      : plumbing;;
-		write-tree)       : plumbing;;
-		verify-tag)       : plumbing;;
-		*) echo $i;;
-		esac
-	done
+	git help | sed -e '
+		1,/^The most commonly used git/d
+		s/^ *\([^ ][^ ]*\)[ ].*/\1/
+	'
 }
 __git_commandlist=
 __git_commandlist="$(__git_commands 2>/dev/null)"
diff --git a/generate-cmdlist.sh b/generate-cmdlist.sh
index 17df47b..28f9749 100755
--- a/generate-cmdlist.sh
+++ b/generate-cmdlist.sh
@@ -9,35 +9,11 @@ struct cmdname_help
 
 static struct cmdname_help common_cmds[] = {"
 
-sort <<\EOF |
-add
-apply
-archive
-bisect
-branch
-checkout
-cherry-pick
-clone
-commit
-diff
-fetch
-grep
-init
-log
-merge
-mv
-prune
-pull
-push
-rebase
-reset
-revert
-rm
-show
-show-branch
-status
-tag
-EOF
+sed -n -e '
+	1,/__DATA__/d
+	s/^git-\([^ 	]*\)[ 	].*[ 	]common/\1/p
+' Documentation/cmd-list.perl |
+sort |
 while read cmd
 do
      sed -n '
