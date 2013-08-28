From: Junio C Hamano <gitster@pobox.com>
Subject: Re: the pager
Date: Wed, 28 Aug 2013 13:26:12 -0700
Message-ID: <xmqqr4dd8suz.fsf@gitster.dls.corp.google.com>
References: <201308261957.r7QJvfjF028935@freeze.ariadne.com>
	<xmqqd2ozhhob.fsf@gitster.dls.corp.google.com>
	<201308281819.r7SIJmnh025977@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: worley@alum.mit.edu (Dale R. Worley)
X-From: git-owner@vger.kernel.org Wed Aug 28 22:26:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEmJt-0005cN-FC
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 22:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755332Ab3H1U0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 16:26:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36908 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755326Ab3H1U0R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 16:26:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F61C3C757;
	Wed, 28 Aug 2013 20:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IvIMQUCQu0gS5ifqZ4Zea9lJeu0=; b=L0Hd03
	670yLsIbfzjc/xTNIcmXu4izsreRJuF0Va2sjAtO9ntuoySN/Wt4B8L4unciGYkG
	gLu5AA2IFKzSMO+DYKaMaqIx4PGR9r7K9kyEFvwDU/49GaGhkwJYUFMcqsrWq4TN
	BYnxEWeR6o3Ex2ezhAH2zsxaIx7+qsGHNHSrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H1ErdfkykYbbG2rkptzEjWz9uJ/OgzdF
	VCaNxll5EyOb/yX8B8do7IzXd6CvtSALyKz2ilLgS68MCfRhlQKpBw/NxpXZkaHQ
	0jFiD2wzNGhQ+zMdCBbgQDsAix752wYBVxioVl5DP8nC6GVSanBvXk2VH0TCBZGK
	rKd5yJyS96Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 329633C756;
	Wed, 28 Aug 2013 20:26:16 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7BF5B3C753;
	Wed, 28 Aug 2013 20:26:14 +0000 (UTC)
In-Reply-To: <201308281819.r7SIJmnh025977@freeze.ariadne.com> (Dale
	R. Worley's message of "Wed, 28 Aug 2013 14:19:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 16019278-1020-11E3-A80B-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233209>

worley@alum.mit.edu (Dale R. Worley) writes:

>> From: Junio C Hamano <gitster@pobox.com>
>> 
>> > I've noticed that Git by default puts long output through "less" as a
>> > pager.  I don't like that, but this is not the time to change
>> > established behavior.  But while tracking that down, I noticed that
>> > the paging behavior is controlled by at least 5 things:
>> >
>> > the -p/--paginate/--no-pager options
>> > the GIT_PAGER environment variable
>> > the PAGER environment variable
>> > the core.pager Git configuration variable
>> > the build-in default (which seems to usually be "less")
>> > ...
>> > What is the (intended) order of precedence of specifiers of paging
>> > behavior?  My guess is that it should be the order I've given above.
>> 
>> I think that sounds about right (I didn't check the code, though).
>> The most specific to the command line invocation (i.e. option)
>> trumps the environment, which trumps the configured default, and the
>> hard wired stuff is used as the fallback default.
>> 
>> I am not sure about PAGER environment and core.pager, though.
>> People want Git specific pager that applies only to Git process
>> specified to core.pager, and still want to use their own generic
>> PAGER to other programs, so my gut feeling is that it would make
>> sense to consider core.pager a way to specify GIT_PAGER without
>> contaminating the environment, and use both to override the generic
>> PAGER (in other words, core.pager should take precedence over PAGER
>> as far as Git is concerned).
>
> I've just discovered this bit of documentation.  Within the git-var
> manual page is this entry:
>
>        GIT_PAGER
>            Text viewer for use by git commands (e.g., less). The value is
>            meant to be interpreted by the shell. The order of preference is
>            the $GIT_PAGER environment variable, then core.pager configuration,
>            then $PAGER, and then finally less.
>
> This suggests that the ordering is GIT_PAGER > core.pager > PAGER >
> default.

OK, that means that my gut feeling was right, we do the right thing,
and we do document it.

But your original "documentation in git.1 and git-config.1, and the
two are not coordinated to make it clear what happens in all cases."
still stands. How can we improve the documentation to make the above
paragraph easier to discover?  Perhaps use the above wording to
update git-config.1 that already mentions GIT_PAGER in the section
for core.pager?

The description over there is so incoherent that I needed to read it
three times to see what points are mentioned.

How about doing this?

-- >8 --
config: rewrite core.pager documentation

The text mentions core.pager and GIT_PAGER without giving the
overall picture of precedences.  Borrow a better description from
the git-var(1) documentation.

The use of the mechanism to allow system-wide, global and
per-repository configuration files is not limited to this particular
variable.  Remove it to clarify the paragraph.

Rewrite the part that explains how the environment variable LESS is
set to Git's default value, and how to selectively customize it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ec57a15..7f9bc38 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -553,22 +553,18 @@ sequence.editor::
 	When not configured the default commit message editor is used instead.
 
 core.pager::
-	The command that Git will use to paginate output.  Can
-	be overridden with the `GIT_PAGER` environment
-	variable.  Note that Git sets the `LESS` environment
-	variable to `FRSX` if it is unset when it runs the
-	pager.  One can change these settings by setting the
-	`LESS` variable to some other value.  Alternately,
-	these settings can be overridden on a project or
-	global basis by setting the `core.pager` option.
-	Setting `core.pager` has no effect on the `LESS`
-	environment variable behaviour above, so if you want
-	to override Git's default settings this way, you need
-	to be explicit.  For example, to disable the S option
-	in a backward compatible manner, set `core.pager`
-	to `less -+S`.  This will be passed to the shell by
-	Git, which will translate the final command to
-	`LESS=FRSX less -+S`.
+	Text viewer for use by Git commands (e.g., 'less').  The value
+	is meant to be interpreted by the shell.  The order of preference
+	is the `$GIT_PAGER` environment variable, then `core.pager`
+	configuration, then `$PAGER`, and then the default chosen at
+	compile time (usually 'less').
++
+When the `LESS` environment variable is unset, Git sets it to `FRSX`
+(if `LESS` environment variable is set, Git does not change it at
+all).  If you want to override Git's default setting for `LESS`, you
+can set `core.pager` to `less -+S`.  This will be passed to the
+shell by Git, which will translate the final command to `LESS=FRSX
+less -+S`.
 
 core.whitespace::
 	A comma separated list of common whitespace problems to
