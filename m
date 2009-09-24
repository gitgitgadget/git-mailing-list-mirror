From: Jeff King <peff@peff.net>
Subject: Re: git stash list shows timestamp in stead of "stash number",
 when setting date = local for log in config
Date: Thu, 24 Sep 2009 03:01:21 -0400
Message-ID: <20090924070121.GD24486@coredump.intra.peff.net>
References: <49578b170909150756k3c19912dv28615053a6bd0f7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Alf Kristian =?utf-8?Q?St=C3=B8yle?= <alf.kristian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 09:02:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqiKP-0006x8-PQ
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 09:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387AbZIXHBN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Sep 2009 03:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752482AbZIXHBK
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 03:01:10 -0400
Received: from peff.net ([208.65.91.99]:38878 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752378AbZIXHBK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 03:01:10 -0400
Received: (qmail 3338 invoked by uid 107); 24 Sep 2009 07:04:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 24 Sep 2009 03:04:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Sep 2009 03:01:21 -0400
Content-Disposition: inline
In-Reply-To: <49578b170909150756k3c19912dv28615053a6bd0f7d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129026>

On Tue, Sep 15, 2009 at 04:56:41PM +0200, Alf Kristian St=C3=B8yle wrot=
e:

> Hi. Searched the lists, but haven't found anyone reporting this probl=
em.
>=20
> When doing a "git stash list" I get this strange stash record:
> stash@{Tue Sep 15 16:28:12 2009}: WIP on master: 2262276 ...
>=20
> I have a global config setting on log:
>=20
> [log]
> date =3D local
>=20
> If setting the date config to default or removing the setting, the
> stash record looks correct:
> stash@{0}: WIP on master: 2262276 ...
>=20
> I might be missing something here, but I do find this a bit strange.
> Is this a bug or a feature, and is there a setting I can use (for
> stash) to always show the latter line? I kind of like having local
> timestamps in log.

It's both. :) The stash is just a reflog, which is basically a linear
list of events that changed the ref. So "git stash list" is really just
"git reflog show stash".

When we show reflogs, we usually just number them sequentially, as that
is the way that people generally refer to them. But if you specify a
date format, then we figure you want to see the date (especially
--date=3Drelative), so we show that.  But of course in your case, you h=
ave
set a config option that is about showing the date in general, so it
doesn't really imply the same "I want to see the date".

So I think it is a feature that is being turned on by a bug.

And I think the right solution is to differentiate between command-line
--date and config log.date. The other option would be for "git-stash" t=
o
explicitly pass "--date=3Ddefault" to turn off date-printing. But I thi=
nk
this is a general problem with log.date and showing reflogs, not just
stash.

The patch below implements the former. The only downside I can think of
is if somebody is relying on "log.date" to set the output format for
reflogs, because they really like the date version better. In that case=
,
I think we should wait for them to complain (which I doubt will happen)=
,
and then add a log.reflogDates config option to appease them.

Shawn, reflogs are your thing. Any comments?

diff --git a/log-tree.c b/log-tree.c
index 1c9eefe..1618f3c 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -390,7 +390,9 @@ void show_log(struct rev_info *opt)
 			 */
 			show_reflog_message(opt->reflog_info,
 				    opt->commit_format =3D=3D CMIT_FMT_ONELINE,
-				    opt->date_mode);
+				    opt->date_mode_explicit ?
+					opt->date_mode :
+					DATE_NORMAL);
 			if (opt->commit_format =3D=3D CMIT_FMT_ONELINE)
 				return;
 		}
diff --git a/revision.c b/revision.c
index 9eb7951..5988b6c 100644
--- a/revision.c
+++ b/revision.c
@@ -1159,8 +1159,10 @@ static int handle_revision_opt(struct rev_info *=
revs, int argc, const char **arg
 		revs->simplify_history =3D 0;
 	} else if (!strcmp(arg, "--relative-date")) {
 		revs->date_mode =3D DATE_RELATIVE;
+		revs->date_mode_explicit =3D 1;
 	} else if (!strncmp(arg, "--date=3D", 7)) {
 		revs->date_mode =3D parse_date_format(arg + 7);
+		revs->date_mode_explicit =3D 1;
 	} else if (!strcmp(arg, "--log-size")) {
 		revs->show_log_size =3D 1;
 	}
diff --git a/revision.h b/revision.h
index 9d0dddb..b6421a6 100644
--- a/revision.h
+++ b/revision.h
@@ -81,7 +81,8 @@ struct rev_info {
 			show_merge:1,
 			abbrev_commit:1,
 			use_terminator:1,
-			missing_newline:1;
+			missing_newline:1,
+			date_mode_explicit:1;
 	enum date_mode date_mode;
=20
 	unsigned int	abbrev;
