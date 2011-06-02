From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] Added a remote helper to interact with mediawiki,
 pull & clone handled
Date: Thu, 2 Jun 2011 13:03:27 -0400
Message-ID: <20110602170327.GA2928@sigill.intra.peff.net>
References: <1307006911-4326-1-git-send-email-arnaud.lacurie@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?SsOpcsOpbWll?= Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Sylvain =?utf-8?Q?Boulm=C3=A9?= <sylvain.boulme@imag.fr>
To: Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Thu Jun 02 19:03:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QSBJ1-0000hU-K0
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 19:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753529Ab1FBRDa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2011 13:03:30 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52449
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262Ab1FBRDa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2011 13:03:30 -0400
Received: (qmail 29799 invoked by uid 107); 2 Jun 2011 17:03:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 02 Jun 2011 13:03:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jun 2011 13:03:27 -0400
Content-Disposition: inline
In-Reply-To: <1307006911-4326-1-git-send-email-arnaud.lacurie@ensimag.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174961>

On Thu, Jun 02, 2011 at 11:28:31AM +0200, Arnaud Lacurie wrote:

> +sub mw_import {
> [...]
> +		# Get 500 revisions at a time due to the mediawiki api limit
> +		while (1) {
> +			my $result =3D $mediawiki->api($query);
> +
> +			# Parse each of those 500 revisions
> +			foreach my $revision (@{$result->{query}->{pages}->{$id}->{revisi=
ons}}) {
> +				my $page_rev_ids;
> +				$page_rev_ids->{pageid} =3D $page->{pageid};
> +				$page_rev_ids->{revid} =3D $revision->{revid};
> +				push (@revisions, $page_rev_ids);
> +				$revnum++;
> +			}
> +			last unless $result->{'query-continue'};
> +			$query->{rvstartid} =3D $result->{'query-continue'}->{revisions}-=
>{rvstartid};
> +			print "\n";
> +		}

What is this newline at the end here for? With it, my import reliably
fails with:

  fatal: Unsupported command:=20
  fast-import: dumping crash report to .git/fast_import_crash_6091

Removing it seems to make things work.

> +		my $user =3D $rev->{user} || 'Anonymous';
> +		my $dt =3D DateTime::Format::ISO8601->parse_datetime($rev->{timest=
amp});
> +
> +		my $comment =3D defined $rev->{comment} ? $rev->{comment} : '*Empt=
y MediaWiki Message*';

In importing the git wiki, I ran into an empty timestamp. This throws a=
n
exception which kills the whole import:

  $ git clone mediawiki::https://git.wiki.kernel.org/ git-wiki
  2821/7949: Revision n=C2=B04210 of GitSurvey
  Invalid date format:  at /home/peff/compile/git/contrib/mw-to-git/git=
-remote-mediawiki line 195
          main::mw_import('https://git.wiki.kernel.org/') called at /ho=
me/peff/compile/git/contrib/mw-to-git/git-remote-mediawiki line 42

At the very least, we should intercept this and put in some placeholder
timestamp. I'm not sure what the best placeholder would be. Maybe use
the date from the previous revision, plus one second? Or maybe there is
some other bug causing us to have an empty timestamp. I didn't dig
deeper yet.

> +		# mediawiki revision number in the git note
> +		my $note_comment =3D encode_utf8("note added by git-mediawiki");
> +		my $note_comment_length =3D bytes::length($note_comment);
> +		my $note_content =3D encode_utf8("mediawiki_revision: " . $pagerev=
ids->{revid} . "\n");
> +		my $note_content_length =3D bytes::length($note_content);
> +
> +		if ($fetch_from =3D=3D 1 && $n =3D=3D 1) {
> +			print "reset refs/notes/commits\n";
> +		}
> +		print "commit refs/notes/commits\n";

Should these go in refs/notes/commits? I don't think we have a "best
practices" yet for the notes namespaces, as it is still a relatively ne=
w
concept. But I always thought "refs/notes/commits" would be for the
user's "regular" notes, and that programmatic things would get their ow=
n
notes, like "refs/notes/mediawiki".

That wouldn't show them by default, but you could do:

  git log --notes=3Dmediawiki

to see them (and maybe that is a feature, because most of the time you
won't care about the mediawiki revision).

> +		} else {
> +			print STDERR "You appear to have cloned an empty mediawiki\n";
> +			#What do we have to do here ? If nothing is done, an error is thr=
own saying that
> +			#HEAD is refering to unknown object 0000000000000000000
> +		}

Hmm. We do allow cloning empty git repos. It might be nice for there to
be some way for a remote helper to signal "everything OK, but the resul=
t
is empty". But I think that is probably something that needs to be adde=
d
to the remote-helper protocol, and so is outside the scope of your
script (maybe it is as simple as interpreting the null sha1 as "empty";
I dunno).

Overall, it's looking pretty good. I like that I can resume a
half-finished import via "git fetch". Though I do have one complaint:
running "git fetch" fetches the metainfo for every revision of every
page, just as it does for an initial clone. Is there something in the
mediawiki API to say "show me revisions since N" (where N would be the
mediawiki revision of the tip of what we imported)?

-Peff
