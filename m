From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Wed, 7 Jan 2009 23:00:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901072213570.7496@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20081104004001.GB29458@artemis.corp>
 <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de> <20081104083042.GB3788@artemis.corp> <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de> <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>
 <20090106111712.GB30766@artemis.corp> <alpine.DEB.1.00.0901062037250.30769@pacific.mpi-cbg.de> <1231359317.6011.12.camel@maia.lan> <alpine.DEB.1.00.0901072121260.7496@intel-tinevez-2-302> <7v63kqall2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>, Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	davidel@xmailserver.org, Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 23:02:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKgT5-00006h-34
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 23:01:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761835AbZAGWAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 17:00:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760933AbZAGWAQ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 17:00:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:47912 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758293AbZAGWAL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 17:00:11 -0500
Received: (qmail invoked by alias); 07 Jan 2009 22:00:09 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp032) with SMTP; 07 Jan 2009 23:00:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18kYkpNnBEk1iz+wdiug674ty279dimjb+gArsspA
	armwyXVIK3K5VQ
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7v63kqall2.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.41
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104838>

Hi,

On Wed, 7 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > After compiling and installing, something like this should be fun to 
> > watch:
> >
> > 	$ git rev-list --all --parents | \
> > 	  grep " .* " | \
> > 	  while read commit parent1 parent2 otherparents
> > 	  do
> > 		test -z "$otherparents" || continue
> > 		git checkout $parent1 &&
> > 		git merge $parent2 &&
> > 		git diff > without-patience.txt &&
> > ...
> > 		if ! cmp without-patience.txt with-patience.txt
> > 		then
> > 			echo '==============================='
> > 			echo "differences found in merge $commit"
> > ...
> > 			cat with-patience.txt
> > 		fi ||
> > 		exit
> > 	  done | tee patience-merge.out
> 
> An even more interesting test would be possible by dropping "&&" from the
> two "git merge" invocations.
> 
>  - Your sample will exit at the first conflicting merge otherwise.
> 
>  - You may find cases where one resolves cleanly while the other leaves
>    conflicts.

Yeah, that's why I always put "like" into that phrase "something like 
this"... :-)

Actually, I had to read something and did not want my box to sit idle 
while I was doing that, so...

The most interesting thing to me was: of the 4072 merges I have in my 
local git.git clone, only 66 show a difference.

The next interesting thing: none -- I repeat, none! -- resulted in only 
one of both methods having conflicts.  In all cases, if patience merge had 
conflicts, so had the classical merge, and vice versa.  I would have 
expected patience merge to handle some conflicts more gracefully.

So let's go on to the next metric: what are the differences in the --cc 
diffs' line counts?

On average, patience merge produced 1.03225806451613 more lines of --cc 
diff, and the standard deviation between the line counts is 
42.9823669772587.

So from the line counts' point of view, the difference is lost in the 
noise.

So let's look at a concrete example.  I take 
41a3e3aa9bdaede9ab7afed206428c1b071060d2, as it is one of the three merges 
with minimal --cc diff line counts (they all have 33 lines) and where 
patience merge makes a difference.

This is the --cc diff without patience merge:

-- snip --
diff --cc git-am.sh
index a391254,5a7695e..0000000
--- a/git-am.sh
+++ b/git-am.sh
@@@ -327,11 -327,20 +327,28 @@@ d
  			echo "Patch is empty.  Was it split wrong?"
  			stop_here $this
  		}
++<<<<<<< HEAD:git-am.sh
 +		SUBJECT="$(sed -n '/^Subject/ s/Subject: //p' "$dotest/info")"
 +		case "$keep_subject" in -k)  SUBJECT="[PATCH] $SUBJECT" ;; esac
 +
 +		(printf '%s\n\n' "$SUBJECT"; cat "$dotest/msg") |
 +			git stripspace > "$dotest/msg-clean"
++=======
+ 		if test -f "$dotest/rebasing" &&
+ 			commit=$(sed -e 's/^From \([0-9a-f]*\) .*/\1/' \
+ 				-e q "$dotest/$msgnum") &&
+ 			test "$(git cat-file -t "$commit")" = commit
+ 		then
+ 			git cat-file commit "$commit" |
+ 			sed -e '1,/^$/d' >"$dotest/msg-clean"
+ 		else
+ 			SUBJECT="$(sed -n '/^Subject/ s/Subject: //p' "$dotest/info")"
+ 			case "$keep_subject" in -k)  SUBJECT="[PATCH] $SUBJECT" ;; esac
+ 
+ 			(echo "$SUBJECT" ; echo ; cat "$dotest/msg") |
+ 				git stripspace > "$dotest/msg-clean"
+ 		fi
++>>>>>>> 5e835cac8622373724235d299f1331ac4cf81ccf:git-am.sh
  		;;
  	esac
  
-- snap --

Compare this with the --cc diff _with_ patience merge:

-- snip --
diff --cc git-am.sh
index a391254,5a7695e..0000000
--- a/git-am.sh
+++ b/git-am.sh
@@@ -327,11 -327,20 +327,25 @@@ d
  			echo "Patch is empty.  Was it split wrong?"
  			stop_here $this
  		}
- 		SUBJECT="$(sed -n '/^Subject/ s/Subject: //p' "$dotest/info")"
- 		case "$keep_subject" in -k)  SUBJECT="[PATCH] $SUBJECT" ;; esac
- 
+ 		if test -f "$dotest/rebasing" &&
+ 			commit=$(sed -e 's/^From \([0-9a-f]*\) .*/\1/' \
+ 				-e q "$dotest/$msgnum") &&
+ 			test "$(git cat-file -t "$commit")" = commit
+ 		then
+ 			git cat-file commit "$commit" |
+ 			sed -e '1,/^$/d' >"$dotest/msg-clean"
+ 		else
+ 			SUBJECT="$(sed -n '/^Subject/ s/Subject: //p' "$dotest/info")"
+ 			case "$keep_subject" in -k)  SUBJECT="[PATCH] $SUBJECT" ;; esac
+ 
++<<<<<<< HEAD:git-am.sh
 +		(printf '%s\n\n' "$SUBJECT"; cat "$dotest/msg") |
 +			git stripspace > "$dotest/msg-clean"
++=======
+ 			(echo "$SUBJECT" ; echo ; cat "$dotest/msg") |
+ 				git stripspace > "$dotest/msg-clean"
+ 		fi
++>>>>>>> 5e835cac8622373724235d299f1331ac4cf81ccf:git-am.sh
  		;;
  	esac
  
-- snap --

So, the patience merge resulted in a much smaller _conflict_.

However, another such merge is 276328ffb87cefdc515bee5f09916aea6e0244ed.  
This is the --cc diff without patience merge:

-- snip --
diff --cc diff.c
index 4e4e439,f91f256..0000000
--- a/diff.c
+++ b/diff.c
@@@ -1498,19 -1464,13 +1498,28 @@@ static void builtin_diff(const char *na
  	char *a_one, *b_two;
  	const char *set = diff_get_color_opt(o, DIFF_METAINFO);
  	const char *reset = diff_get_color_opt(o, DIFF_RESET);
 +	const char *a_prefix, *b_prefix;
 +
 +	diff_set_mnemonic_prefix(o, "a/", "b/");
 +	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
 +		a_prefix = o->b_prefix;
 +		b_prefix = o->a_prefix;
 +	} else {
 +		a_prefix = o->a_prefix;
 +		b_prefix = o->b_prefix;
 +	}
  
++<<<<<<< HEAD:diff.c
 +	a_one = quote_two(a_prefix, name_a + (*name_a == '/'));
 +	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
++=======
+ 	/* Never use a non-valid filename anywhere if at all possible */
+ 	name_a = DIFF_FILE_VALID(one) ? name_a : name_b;
+ 	name_b = DIFF_FILE_VALID(two) ? name_b : name_a;
+ 
+ 	a_one = quote_two(o->a_prefix, name_a + (*name_a == '/'));
+ 	b_two = quote_two(o->b_prefix, name_b + (*name_b == '/'));
++>>>>>>> e261cf94848d31868c21fb11cade51c30dfcdbe7:diff.c
  	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
  	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
  	fprintf(o->file, "%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
-- snap --

And this is _with_ patience merge:

-- snip --
diff --cc diff.c
index 4e4e439,f91f256..0000000
--- a/diff.c
+++ b/diff.c
@@@ -1498,19 -1464,13 +1498,28 @@@ static void builtin_diff(const char *na
  	char *a_one, *b_two;
  	const char *set = diff_get_color_opt(o, DIFF_METAINFO);
  	const char *reset = diff_get_color_opt(o, DIFF_RESET);
 +	const char *a_prefix, *b_prefix;
 +
++<<<<<<< HEAD:diff.c
 +	diff_set_mnemonic_prefix(o, "a/", "b/");
 +	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
 +		a_prefix = o->b_prefix;
 +		b_prefix = o->a_prefix;
 +	} else {
 +		a_prefix = o->a_prefix;
 +		b_prefix = o->b_prefix;
 +	}
  
 +	a_one = quote_two(a_prefix, name_a + (*name_a == '/'));
 +	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
++=======
+ 	/* Never use a non-valid filename anywhere if at all possible */
+ 	name_a = DIFF_FILE_VALID(one) ? name_a : name_b;
+ 	name_b = DIFF_FILE_VALID(two) ? name_b : name_a;
+ 
+ 	a_one = quote_two(o->a_prefix, name_a + (*name_a == '/'));
+ 	b_two = quote_two(o->b_prefix, name_b + (*name_b == '/'));
++>>>>>>> e261cf94848d31868c21fb11cade51c30dfcdbe7:diff.c
  	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
  	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
  	fprintf(o->file, "%sdiff --git %s %s%s\n", set, a_one, b_two, reset);
-- snap --

So again, we have no clear winner.

Therefore I counted the lines between conflict markers (actually, a perl 
script did).  Of these 66 merges, on average patience merge produced 
4.46774193548387 _fewer_ lines between conflict markers.

Take that with a grain of salt, though: the standard deviation of this 
difference is a hefty 121.163046639509 lines.

The worst case for patience diff was the merge 
4698ef555a1706fe322a68a02a21fb1087940ac3, where the --cc diff line counts 
are 1300 (without) vs 1301 (with patience merge), but the lines between 
conflict markers are 197 vs a ridiculous 826 lines!

But you should take that also with a grain of salt: this merge is a 
_subtree_ merge, and my test redid it as a _non-subtree_ merge.

So I restricted the analysis to the non-subtree merges, and now 
non-patience merge comes out 6.97297297297297 conflict lines fewer than 
patience merge, with a standard deviation of 58.941106657867 (with a total 
count of 37 merges).

Note that ~7 lines difference with a standard deviation of ~59 lines is 
pretty close to ~0 lines difference.

In the end, the additional expense of patience merge might just not be 
worth it.

Ciao,
Dscho
