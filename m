Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF3E920248
	for <e@80x24.org>; Tue, 26 Mar 2019 06:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbfCZGnQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 02:43:16 -0400
Received: from home.mewburn.net ([121.127.199.9]:37724 "EHLO home.mewburn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732438AbfCZGhw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 02:37:52 -0400
X-Greylist: delayed 530 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Mar 2019 02:37:50 EDT
Received: by home.mewburn.net (Postfix, from userid 1001)
        id 4765461223; Tue, 26 Mar 2019 17:28:58 +1100 (AEDT)
Date:   Tue, 26 Mar 2019 17:28:58 +1100
From:   Luke Mewburn <luke@mewburn.net>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Luke Mewburn <luke@mewburn.net>
Subject: Re: [PATCH 2/5] progress: return early when in the background
Message-ID: <20190326062858.GE4753@mewburn.net>
References: <20190325103844.26749-1-szeder.dev@gmail.com>
 <20190325103844.26749-3-szeder.dev@gmail.com>
 <8736nbcitc.fsf@evledraar.gmail.com>
 <20190325113913.GL22459@szeder.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
In-Reply-To: <20190325113913.GL22459@szeder.dev>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19-03-25 12:39, SZEDER G=E1bor wrote:
  | On Mon, Mar 25, 2019 at 12:08:47PM +0100, =C6var Arnfj=F6r=F0 Bjarmason=
 wrote:
  | >=20
  | > On Mon, Mar 25 2019, SZEDER G=E1bor wrote:
  | >=20
  | > > When a git process runs in the background, it doesn't display
  | > > progress, only the final "done" line [1].  The condition to check t=
hat
  | > > are a bit too deep in the display() function, and thus it calculates
  | > > the progress percentage even when no progress will be displayed
  | > > anyway.
  | > >
  | > > Restructure the display() function to return early when we are in t=
he
  | > > background, which prevents the unnecessary progress percentae
  | > > calculation, and make the function look a bit better by losing one
  | > > level of indentation.
  | > >
  | > > [1] 85cb8906f0 (progress: no progress in background, 2015-04-13)
  | >=20
  | > CC-ing the author of that patch.
  | >=20
  | > > Signed-off-by: SZEDER G=E1bor <szeder.dev@gmail.com>
  | > > ---
  | > >  progress.c | 26 ++++++++++++++------------
  | > >  1 file changed, 14 insertions(+), 12 deletions(-)
  | > >
  | > > diff --git a/progress.c b/progress.c
  | > > index 02a20e7d58..b57c0dae16 100644
  | > > --- a/progress.c
  | > > +++ b/progress.c
  | > > @@ -86,28 +86,30 @@ static void display(struct progress *progress, =
uint64_t n, const char *done)
  | > >  		return;
  | > >
  | > >  	progress->last_value =3D n;
  | > > +
  | > > +	if (!is_foreground_fd(fileno(stderr)) && !done) {
  | > > +		progress_update =3D 0;
  | > > +		return;
  | > > +	}
  | > > +
  | > >  	tp =3D (progress->throughput) ? progress->throughput->display.buf=
 : "";
  | > >  	eol =3D done ? done : "   \r";
  | > >  	if (progress->total) {
  | > >  		unsigned percent =3D n * 100 / progress->total;
  | > >  		if (percent !=3D progress->last_percent || progress_update) {
  | > >  			progress->last_percent =3D percent;
  | > > -			if (is_foreground_fd(fileno(stderr)) || done) {
  | > > -				fprintf(stderr, "%s: %3u%% (%"PRIuMAX"/%"PRIuMAX")%s%s",
  | > > -					progress->title, percent,
  | > > -					(uintmax_t)n, (uintmax_t)progress->total,
  | > > -					tp, eol);
  | > > -				fflush(stderr);
  | > > -			}
  | > > +			fprintf(stderr, "%s: %3u%% (%"PRIuMAX"/%"PRIuMAX")%s%s",
  | > > +				progress->title, percent,
  | > > +				(uintmax_t)n, (uintmax_t)progress->total,
  | > > +				tp, eol);
  | > > +			fflush(stderr);
  | > >  			progress_update =3D 0;
  | > >  			return;
  | > >  		}
  | > >  	} else if (progress_update) {
  | > > -		if (is_foreground_fd(fileno(stderr)) || done) {
  | > > -			fprintf(stderr, "%s: %"PRIuMAX"%s%s",
  | > > -				progress->title, (uintmax_t)n, tp, eol);
  | > > -			fflush(stderr);
  | > > -		}
  | > > +		fprintf(stderr, "%s: %"PRIuMAX"%s%s",
  | > > +			progress->title, (uintmax_t)n, tp, eol);
  | > > +		fflush(stderr);
  | > >  		progress_update =3D 0;
  | > >  		return;
  | > >  	}
  | >=20
  | > This patch looks good, just notes for potential follow-up:
  | >=20
  | >  * Is the "is_foreground_fd(fileno(stderr))" case worth moving into
  | >    start_progress_delay() & setting a variable? It's a few C lib call=
s &
  | >    potential syscall (getpid(...)).
  |=20
  | It depends on whether you consider the following case worth caring
  | about:
  |=20
  |   $ git long-cmd
  |   <shows progress>
  |   Ctrl-Z!
  |   $ bg
  |   <silent>
  |   $ fg
  |   <shows progress>
  |=20
  | Or:
  |=20
  |   $ git long-cmd &
  |   <silent>
  |   $ fg
  |   <shows progress>
  |=20
  | By moving the is_foreground_fd() check to start_progress_delay() and
  | caching its result, in the first case we would print progress even
  | after the process is sent to the background, while in the second we
  | wouldn't print progress even after the initially backgrounded process
  | is brought to the foreground.
  |=20
  | I think the current behavior makes sense (though I'm not quite sure
  | about printing the final "done" line, as I think I would be annoyed if
  | it were printed from the background process while I was typing a
  | longer command... but I don't run git commands in the background in
  | the first place)

You've described the current behaviour as I intended it
in the original patch. I.e,:
- Display progress if foreground.
- Suppress output if background.
- Check the foreground/background state each update in case it changed.

I based that on other tools that also dynamically change their
output/progress behaviour whether in the foreground or background.

Regarding the final "done" line; I think that's a matter of
personal preference. I'm not too fussed if that was changed
so that "done" isn't printed if in the background.


  |=20
  | >  * Is that "|| done" part in the "progress_update" case something that
  | >    needs to happen? I.e. can we entirely skip the "setup signal handl=
er"
  | >    part in start_progress_delay() if we detect that we're not in the
  | >    foreground, and then rely on the stop_progress() call to print the
  | >    "done"?
  |=20
  | This, too, depends on how (or whether at all) we want to handle the
  | user sending the process to the background and bringing it back.
  |=20
  | >    Although we set "progress_update =3D 1" in stop_progress_msg(), so=
 it's
  | >    not *just* the signal handler but also us "faking" it, and we'd st=
ill
  | >    need to stash away "progress->last_value =3D n" in display() in th=
at
  | >    backgrounding case.
  | >=20
  | >    So maybe it's as simple as it's going to get.
  |=20



regards,
Luke.

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAlyZxqoACgkQpBhtmn8zJHJd5gCgudEKF9dRiqKc9WUQxOzE/UgO
uxcAn0JibH7uRvaSJBP3Y/xe5GowMm9k
=gB0b
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
