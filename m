From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] rev-list: make --max- and --min-age a bit more usable.
Date: Wed, 02 Nov 2005 11:02:40 -0800
Message-ID: <7vbr12swj3.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vd5lnztav.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510301838110.27915@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 20:05:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXNsq-0001Rp-F5
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 20:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965184AbVKBTCm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 2 Nov 2005 14:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965183AbVKBTCm
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Nov 2005 14:02:42 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:21200 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S965184AbVKBTCl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2005 14:02:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102190216.LRQQ9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 2 Nov 2005 14:02:16 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510301838110.27915@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 30 Oct 2005 18:52:11 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11028>

Linus Torvalds <torvalds@osdl.org> writes:

> I've several times been surprised to see people not realize that
> "git-whatchanged" takes a file list to limit the files it is interested 
> in. I also suspect people don't realize that you can limit it by time and 
> version and file list, all at the same time.

The current "time based limiting" is not very user friendly, so
people not knowing the limit-by-time is not a surprise.

> 	git-whatchanged -p --pretty=short --since="2 weeks ago" v0.99.8..v0.99.9 Makefile
>
> is a valid query

Well, it is not a valid query ;-) Nobody implemented --since
yet, but you could spell it --max-age.  It would not grok "2
weeks ago" though.

With the attached patch, you could at least do:

	git log --max-age='2005-10-25' v0.99.8..v0.99.9 Makefile

There are still a couple of things that bothers me.

(1) The underlying workhorse, rev-list, takes max-age and
    min-age.  While these names are logically correct, it feels
    a bit hard and counterintuitive when deciding which one to
    use in order to ask "what are the ones that happened after
    Wednesday last week?".  The query talks about the commits
    being young, so --max-age=2005-10-26 is the right query
    (i.e. "I want to discard things that are older than that
    time"), but as soon as I type "max", my mind starts
    comparing date strings, and surely 2005-10-21 is smaller
    than 2005-10-26 and I am saying 2005-10-26 is the max, which
    confuses me to think that 2005-10-21 would be included in
    the result (it would not be -- we are talking about age, so
    2005-10-21 one is older, which means its age is greater than
    specified). It takes some mental effort to do this, at least
    for me.

    I *hate* to suggest this change at this late stage of the
    game, but maybe they should be renamed or at least acquire 
    less confusing synonyms, perhaps?

	--max-age	= --min-timestamp, --since
        --min-age	= --max-timestamp, --until

(2) If I run the above --max-age query, the last commit
    displayed is this one:

        commit f3123c4ab3d3698262e59561ac084de45b10365a
        Author: Junio C Hamano <junkio@cox.net>
        Date:   Sat Oct 22 01:28:13 2005 -0700

    This is because the age limit uses commit date (which is a
    sensible thing to do) while the display shows author date.
    To an uninitiated, this takes some explanation and
    justification (i.e. counterintuitive again).

    Incidenally, I have not found a way to prettyprint the
    commit date; --pretty=raw gives that information, but in
    really raw format.  --pretty=full does not even give any
    timestamp.

    Again I *hate* to suggest this, but maybe --pretty=full
    should show both author and commit timestamp as well, like
    this?

        commit f3123c4ab3d3698262e59561ac084de45b10365a
        Author: Junio C Hamano <junkio@cox.net>
        A-Date: Sat Oct 22 01:28:13 2005 -0700
        Commit: Junio C Hamano <junkio@cox.net>
        C-Date: Wed Oct 26 12:37:49 2005 -0700


-- >8 -- cut here -- >8 --

Earlier we just did atoi to accept these parameters, which meant
that the user needed to specify the raw UNIX time format to use
them.

This still does not make it accept '2 weeks ago', but at least
it now can take --max-age='2005-10-15', which is a start.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 rev-list.c |   19 +++++++++++++++++--
 1 files changed, 17 insertions(+), 2 deletions(-)

applies-to: 0c9683fe37dbc43713faaa15fcce14bfe5621bba
9dc13af3f916803d270d3387032eb0e91b940417
diff --git a/rev-list.c b/rev-list.c
index 6e6ffde..7a73703 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -712,6 +712,21 @@ static void handle_all(struct commit_lis
 	global_lst = NULL;
 }
 
+static unsigned long getdate(const char *arg, const char *label)
+{
+	char text[80];
+	unsigned long date;
+
+	if (parse_date(arg, text, sizeof(text)) < 0) {
+		/* Maybe handle "4 days ago" and the like here... */
+		die("bad time specification for %s: %s", label, arg);
+	}
+	date = strtoul(text, NULL, 10);
+	if (date == ULONG_MAX)
+		die("unparsable time specification for %s: %s", label, arg);
+	return date;
+}
+
 int main(int argc, const char **argv)
 {
 	const char *prefix = setup_git_directory();
@@ -730,12 +745,12 @@ int main(int argc, const char **argv)
 			continue;
 		}
 		if (!strncmp(arg, "--max-age=", 10)) {
-			max_age = atoi(arg + 10);
+			max_age = getdate(arg + 10, "max-age");
 			limited = 1;
 			continue;
 		}
 		if (!strncmp(arg, "--min-age=", 10)) {
-			min_age = atoi(arg + 10);
+			min_age = getdate(arg + 10, "min-age");
 			limited = 1;
 			continue;
 		}
---
0.99.9.GIT
