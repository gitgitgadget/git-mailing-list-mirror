From: Onno Kortmann <onno@gmx.net>
Subject: Re: [PATCH] Show number of commits being rebased interactively
Date: Wed, 10 Dec 2014 19:16:44 +0100
Message-ID: <54888E0C.4050402@gmx.net>
References: <5460E893.7080003@gmx.net>	<xmqq388tpyls.fsf@gitster.dls.corp.google.com>	<5484BEFD.7060906@gmx.net> <xmqqbnncmys1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 19:16:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xyloj-00053D-Po
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 19:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbaLJSQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 13:16:50 -0500
Received: from mout.gmx.net ([212.227.17.22]:64526 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932414AbaLJSQt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 13:16:49 -0500
Received: from [192.168.6.43] ([95.119.207.107]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0LtJ5T-1XoYKc3387-012lh6; Wed, 10 Dec 2014 19:16:45
 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <xmqqbnncmys1.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:NPSbxxlesxq0DLPc8iWbsjeZsMe9qX6cxNQp8AUMDNfZCHyqm5i
 xM3mf+qhjy9a9R4MQFoaV9TWc9XcBL9E1riiLAB28C7TGQZ5heSsEgys+lVY+/Xf4p4oD26
 uv9wHanbNfpdX/RjL9uIFJ1ubjludM9WVOsGWbRVfT/dOynxsZixlzfoYu5CEj2nvIh+rN1
 qYLK3u/rEYsKkK4tyrmZQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261234>

Hi,

>> In the case of having 'exec' lines interspersed, the $commitcount
>> becomes a lot less useful (no comparison to editor line numbers),
>> though.
>
> Hmph, interesting.  Then perhaps not filtering at all and instead
> labelling this new piece of information not "commit(s)" a better
> solution?  You are counting the number of instructions in the insn
> sheet, so perhaps something like "($count todo items(s))" or
> something?
Yes that sounds good. Though I lack the experience to say what would
be the typical workflow for someone who uses rebase-i a lot with execs
interspersed(?)

In all cases, simply counting and noting '#todo item(s)' would always be
a correct labelling and simple to understand, albeit not necessarily a
very helpful value. But at least for pure picks/edit/squash lists,
it will allow a quick sanity check.

Also, I noted that filtering for ^pick will not be good
in case one uses '--autosquash'.

>> 8< 8< 8< 8< 8< 8< 8< 8< 8<
>
> That is not a scissors line, I suspect.
>
> I didn't try running "git am" on this message, though.  Did you?
Yes, I RTFMed on git-mailinfo and to be sure I tested this before sending
the last mail out :)

Below is the patch, changed to say 'TODO items', and with updated commit
message.

Cheers,

Onno

8< 8< 8< 8< 8< 8< 8< 8< 8<
Subject: [PATCH] Show number of TODO items for interactive rebase

During 'rebase -i', one wrong edit in a long rebase session
might inadvertently drop commits/items. This change shows
the total number of TODO items in the comments after the
list. After performing the rebase edit, total item counts
can be compared to make sure that no changes have been lost
in the edit.

Signed-off-by: Onno Kortmann <onno@gmx.net>
---
 git-rebase--interactive.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b64dd28..c6a4629 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1031,9 +1031,11 @@ test -s "$todo" || echo noop >> "$todo"
 test -n "$autosquash" && rearrange_squash "$todo"
 test -n "$cmd" && add_exec_commands "$todo"

+todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
+
 cat >>"$todo" <<EOF

-$comment_char Rebase $shortrevisions onto $shortonto
+$comment_char Rebase $shortrevisions onto $shortonto ($todocount TODO item(s))
 EOF
 append_todo_help
 git stripspace --comment-lines >>"$todo" <<\EOF
--
2.2.0.34.gb8f29bf
