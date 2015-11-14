From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH RFC] completion: add support for completing email
 aliases
Date: Sat, 14 Nov 2015 01:55:04 +0100
Message-ID: <20151114015504.Horde.4mcBf20X0mnolD3xNrtymin@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Lee Marlow <lee.marlow@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Sat Nov 14 02:11:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxPNB-0008P2-EQ
	for gcvg-git-2@plane.gmane.org; Sat, 14 Nov 2015 02:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752306AbbKNBLR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Nov 2015 20:11:17 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:54382 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751348AbbKNBLQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 20:11:16 -0500
X-Greylist: delayed 966 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Nov 2015 20:11:16 EST
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1ZxP7S-0000HN-Dg; Sat, 14 Nov 2015 01:55:06 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1ZxP7Q-0005bu-8r; Sat, 14 Nov 2015 01:55:04 +0100
Received: from x590c4f09.dyn.telefonica.de (x590c4f09.dyn.telefonica.de
 [89.12.79.9]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Sat, 14 Nov 2015 01:55:04 +0100
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1447462506.
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1447463474.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281300>


Hi,

Quoting Jacob Keller <jacob.e.keller@intel.com>:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Extract email aliases from the sendemail.aliasesfile according to the
> known types. Implementation only extracts the alias name and does not
> attempt to complete email addresses.
>
> Add a few tests for simple layouts of the currently supported alias
> filetypes.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>
> Labeled this RFC because I have only been able to test the mutt forma=
t
> as this is what I use locally. I have a few (probably brittle) test
> cases for the files, but they are not "real" configuration files as p=
er
> the upstream tools, so they are essentially made to work with the sim=
ple
> extractors that I have now. I'd like some review on this to see if it=
's
> valuable, but it definitely helps me type out aliases and see what is
> available by just using TAB.

I think it's definitely valuable, but I'm unsure about parsing the
different alias file formats in shell (well, in awk...), though some
of the parses are much simpler than I expected.
However, 'git send-email' already knows how to parse these files, so
how about letting it do all the work, i.e. teach it a new 'git
send-email --list-aliases' option that would only read the config,
parse the alias file, print all the aliases, i.e. the keys from the
'aliases' associative array and exit.  That way we wouldn't have to
duplicate parts of an already working and tested parsing into a
different language, the completion script would be simpler, because we
wouldn't need __git_email_aliases() helper function, it would
immediately benefit from future bug fixes to 'send-email', and new
alias file formats would Just Work.

> contrib/completion/git-completion.bash | 69 +++++++++++++++++++++++++=
+
> t/t9902-completion.sh                  | 90
> ++++++++++++++++++++++++++++++++++
> 2 files changed, 159 insertions(+)
>
> diff --git a/contrib/completion/git-completion.bash
> b/contrib/completion/git-completion.bash
> index 482ca84b451b..9b786bb390ba 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -10,6 +10,7 @@
> #    *) local and remote tag names
> #    *) .git/remotes file names
> #    *) git 'subcommands'
> +#    *) git email aliases for git-send-email
> #    *) tree paths within 'ref:path/to/file' expressions
> #    *) file paths within current working directory and index
> #    *) common --long-options
> @@ -785,6 +786,56 @@ __git_aliased_command ()
> 	done
> }
>
> +# Print aliases for email addresses from sendemail.aliasesfile
> +__git_email_aliases ()
> +{
> +	local file=3D"$(git --git-dir=3D"$(__gitdir)" config --path
> sendemail.aliasesfile)"
> +	local filetype=3D"$(git --git-dir=3D"$(__gitdir)" config
> sendemail.aliasfiletype)"

Using $(__gitdir) is good.  Running it twice not so much.  fork()ing a
subshell and fork()+exec()ing a git command is expensive on some
platforms, most importantly Windows.
Please run it only once, store the returned path in a variable, and
pass that to the 'git config' commands.

Sidenote, just wondering: why are these config keys named
'aliasfiletype' and 'alias*es*file'?!

> +	# Only run awk if we find an actual file
> +	if ! [ -f $file ]; then
> +		return
> +	fi

According to the docs multiple alias files can be configured, but this
would only work with one.
That 'git send-email --list-aliases' would take care of this, too.

> +
> +	case "$filetype" in
> +		# Each file type needs to be parsed differently.
> +		mutt|mailrc)
> +			# Mutt and mailrc are simple and just put the alias in
> +			# the 2nd field of the file.
> +			awk '{print $2}' $file
> +			return
> +			;;
> +		sendmail)
> +			# Skip new lines, lines without fields, and lines
> +			# ending in '\' then print the name minus the final :
> +			awk 'NF && $1!~/^#/ && !/\\$/ {sub(/:$/, "", $1); print $1 }' $fi=
le
> +			return
> +			;;
> +		pine)
> +			# According to spec, line continuations are any line
> +			# which starts with whitespace, otherwise we can just
> +			# use the normal separator and print the first field.
> +			awk '/^\S/ {print $1}' "$file"
> +			return
> +			;;
> +		elm)
> +			# Elm doesn't appear to allow newlines, and
> +			# git-send-email only accepts one alias per line, so
> +			# just print the first field.
> +			awk '{print $1}' "$file"
> +			return
> +			;;
> +		gnus)
> +			# The gnus format has the alias quoted, so we just use
> +			# gsub to extract the alias from the quotes
> +			awk '/define-mail-alias/ {gsub(/"/, "", $2); print $2}' $file
> +			return
> +			;;
> +		*)
> +			return;;
> +	esac
> +}

Since there is nothing after the case statement in this function, the
return statements in each branch are unnecessary, as is the last
catch-all branch.

> +
> # __git_find_on_cmdline requires 1 argument
> __git_find_on_cmdline ()
> {
> @@ -1735,6 +1786,24 @@ _git_send_email ()
> 			" "" "${cur##--thread=3D}"
> 		return
> 		;;
> +	--to=3D*)
> +		__gitcomp "
> +		$(__git_email_aliases)
> +		" "" "${cur##--to=3D}"
> +		return
> +		;;
> +	--cc=3D*)
> +		__gitcomp "
> +		$(__git_email_aliases)
> +		" "" "${cur##--cc=3D}"
> +		return
> +		;;
> +	--bcc=3D*)
> +		__gitcomp "
> +		$(__git_email_aliases)
> +		" "" "${cur##--bcc=3D}"
> +		return
> +		;;

These case branches look essentially the same except what has to be
removed from the word being completed.  And what gets removed is
essentially everything before and including the first '=3D'.
So how about squashing these three cases into a single (untested) one
like this:

      --to=3D*|--cc=3D*|--bcc=3D*)
        __gitcomp "$(__git_email_aliases)" "" "${cur#*=3D}"
        return
        ;;

> 	--*)
> 		__gitcomp "--annotate --bcc --cc --cc-cmd --chain-reply-to
> 			--compose --confirm=3D --dry-run --envelope-sender
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index 2ba62fbc178e..0549f75e6e7c 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -404,6 +404,96 @@ test_expect_success '__git_aliases' '
> 	test_cmp expect actual
> '
>
> +test_expect_success '__git_email_aliases (mutt)' '
> +	cat >aliases <<-EOF &&
> +	alias user1 Some User <user1@example.org>
> +	alias user2 random-user-foo@foo.garbage
> +	EOF
> +	cat >expect <<-EOF &&
> +	user1
> +	user2
> +	EOF
> +	test_config sendemail.aliasesfile aliases &&
> +	test_config sendemail.aliasfiletype mutt &&
> +	__git_email_aliases >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '__git_email_aliases (mailrc)' '
> +	cat >aliases <<-EOF &&
> +	alias user1 Some User <user1@example.org>
> +	alias user2 random-user-foo@foo.garbage
> +	EOF
> +	cat >expect <<-EOF &&
> +	user1
> +	user2
> +	EOF
> +	test_config sendemail.aliasesfile aliases &&
> +	test_config sendemail.aliasfiletype mailrc &&
> +	__git_email_aliases >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '__git_email_aliases (sendmail)' '
> +	cat >aliases <<-EOF &&
> +	user1: Some User <user1@example.org>
> +	user2: random-user-foo@foo.garbage
> +	EOF
> +	cat >expect <<-EOF &&
> +	user1
> +	user2
> +	EOF
> +	test_config sendemail.aliasesfile aliases &&
> +	test_config sendemail.aliasfiletype sendmail &&
> +	__git_email_aliases >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '__git_email_aliases (pine)' '
> +	cat >aliases <<-EOF &&
> +	user1	Some User	user1@example.org>
> +	user2	random-user-foo@foo.garbage
> +	EOF
> +	cat >expect <<-EOF &&
> +	user1
> +	user2
> +	EOF
> +	test_config sendemail.aliasesfile aliases &&
> +	test_config sendemail.aliasfiletype pine &&
> +	__git_email_aliases >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '__git_email_aliases (elm)' '
> +	cat >aliases <<-EOF &&
> +	user1 =3D User; Someone =3D user1@example.org
> +	user2 =3D =3D user2@garbage.foo
> +	EOF
> +	cat >expect <<-EOF &&
> +	user1
> +	user2
> +	EOF
> +	test_config sendemail.aliasesfile aliases &&
> +	test_config sendemail.aliasfiletype elm &&
> +	__git_email_aliases >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '__git_email_aliases (gnus)' '
> +	cat >aliases <<-EOF &&
> +	define-mail-alias "user1" "user1@example.org"
> +	define-mail-alias "user2" "user2@arbitrary.foo"
> +	EOF
> +	cat >expect <<-EOF &&
> +	user1
> +	user2
> +	EOF
> +	test_config sendemail.aliasesfile aliases &&
> +	test_config sendemail.aliasfiletype gnus &&
> +	__git_email_aliases >actual &&
> +	test_cmp expect actual
> +'

I didn't check how the contents of these aliases files conform to each
format, but other than that these tests look good.
But then again, with a 'git send-email --list-aliases' option we
wouldn't these tests at all.


Thanks,
G=C3=A1bor

> +
> test_expect_success 'basic' '
> 	run_completion "git " &&
> 	# built-in
> --
> 2.6.1.264.gbab76a9
