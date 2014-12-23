From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 04/18] Offer a function to demote fsck errors to
 warnings
Date: Tue, 23 Dec 2014 11:53:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412231051320.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <2a0c4cd4c5d3aaceff8a6ffa49d2f3597d26086d.1418055173.git.johannes.schindelin@gmx.de> <xmqqoarbidv7.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222232270.21312@s15462909.onlinehome-server.info>
 <xmqqfvc78hwq.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222330080.21312@s15462909.onlinehome-server.info> <xmqqy4pz71g7.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222348040.21312@s15462909.onlinehome-server.info>
 <xmqqlhlz6zti.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-2103865647-1419332016=:21312"
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 11:53:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3N66-0007KY-Eb
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 11:53:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755727AbaLWKxq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 05:53:46 -0500
Received: from mout.gmx.net ([212.227.15.15]:55605 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754887AbaLWKxp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 05:53:45 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MLujU-1Xxsui3WVo-007oan;
 Tue, 23 Dec 2014 11:53:36 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqlhlz6zti.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:ggCOeouJu3CUc6WzkLGQ+1WfP4ar4OXM263F2Ar1te22V0WQ9RW
 p23xTF61LUPmaBJqG/pdfW0xMyCfr6Ksgy0HEzwpn8rot7oniqfxw3k2FU5cBunB3ZGO43V
 bdn0e4/Q4+T7fz1LSf/CuuHB2NBrI/156yKO2CyN1S7o2vuexP0ucryqTQco4AXy5yXWSBy
 GK5dbIimd5yLO0iGcoyEg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261723>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-2103865647-1419332016=:21312
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Mon, 22 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > For example, try to spot the error here:
> >
> > =09...
> > =09F(ALMOST_HAPPY, INFO) \
> > =09F(CANNOT_RECOVER, ERROR) \
> > =09F(COFFEE_IS_EMPTY, WARN) \
> > =09F(JUST_BEING_CHATTY, INFO) \
> > =09F(LIFE_IS_GOOD, INFO) \
> > =09F(MISSING_SOMETHING_VITAL, FATAL_ERROR) \
> > =09F(NEED_TO_SLEEP, WARN) \
> > =09F(SOMETHING_WENT_WRONG, ERROR) \
> > =09...
>=20
> But that is not what is being suggested at all.  I already said that
> FIRST_SOMETHING is fine as a measure to initialize, didn't I?
>=20
> I am only saying that if you have a place to store customized level,
> you should initialize that part with default levels and always look
> it up from that place at runtime.  It is perfectly fine for the
> initialization step to take advantage of the ordering and
> FIRST_SOMETHING constants.

Thanks for clarifying, I was worried that you wanted to encode the
severity levels explicitly (F(ID, LEVEL) instead of F(ID) in the correct
order). The DRY principle also suggests that we should not encode the
severity level in two ways (which would leave the door open for
inconsistencies). That means that we should not initialize a static array
of severity levels, but initialize the array using a loop.

Okay, now that we have established that the initial ordering by severity
makes sense, let's examine the initialization step.

Basically, our approaches differ only in *when* to initialize that array
of severity levels: you want to initialize it always, and I want to
initialize it only when the severity levels are customized by the caller.

Now, let's have a look how the fsck_options are currently initialized. My
code follows the convention established with strbufs, argv_arrays, etc:
there is a preprocessor definition (_DEFAULT, imitating the _INIT
definitions) that allows us to initialize such structs very conveniently.
Please note that no loop is required, and certainly no extra code has to
be called to initialize the struct. We get away with initializing that
array lazily in the fsck_strict_mode() function when we detect that it
needs to be initialized, being populated by the very same function that
provides the default settings before customization. This is a very robust
setup as the knowledge about, say, the size of that array is confined
strictly to fsck.c.

However, if we had to change the lookup such that it uses an array always,
we would have to introduce a function to initialize the struct, always, in
particular we would have to find a place to call that initialization
function in, say, builtin/fsck.c (actually, in every code path that calls
into the fsck machinery). Arguably, the code would get more complex =E2=80=
=93
introducing new call paths just to initialize the fsck_options struct =E2=
=80=93
and I would argue further that there is no gain from an elegance,
readability and maintenance point of view: whether the array is
initialized lazily or not, it will be initialized the exact same way. All
it means is that we have to introduce separate code paths because we would
separate explicitly the initialization from the configuration step.

Therefore, I do not believe that introducing an fsck_options_init() is
what you would really want.

An alternative would be to initialize the array at compile time =E2=80=93 w=
e would
have to violate the DRY principle for that, repeating the severity levels
many times over, and we could no longer confine the visibility to the
message IDs to fsck.c because not only the size of the array of severity
levels would have to be known to every user of fsck.h, but the exact
default severity levels themselves, to be able to initialize the struct.
But we could initialize the struct with a known set of settings via the
_DEFAULTS definition that way.

However, you already expressed slight disagreement with the preprocessor
magic needed to initialize both the enum and the array of message ID
strings from the same list in a way that lets the compiler ensure
consistency; I am afraid that if I were to modify _DEFAULTS to populate the
entire severity level array, the resulting code would find your utter
contempt.

I believe, therefore, that this is also not what you want.

So that leaves only one alternative: to initialize a global array with the
default severity levels at *some* stage. I have no idea what that stage
would be, therefore we would have to either establish ugly, and
DRY-violating, compile time initialization, or we would have to call a
function before using any of the fsck machinery =E2=80=93 but that is fragi=
le: it
is too easy to forget one call path and access an uninitialized array!
Worse, even if we *had* a fully initialized array of default severity
levels, we would still have to have an on-demand copy (i.e. lazy
initialization) of said array lest we modify the global defaults in
fsck_strict_mode()! Essentially, we would just *add* complexity to the
current solution, not replace it with anything simpler.

Therefore, I believe that you cannot be a fan of this alternative, either.

In short, I still find it much more elegant to determine the default
severity levels from the numeric enum values, and initialize the severity
level array only on demand, than to introduce a separate call to
initialize the array always, in particular since we would have to execute
that initialization loop *all* the time in the latter case =E2=80=93 even i=
f we do
not customize, let alone look up, any value =E2=80=93 or clutter the code w=
ith
ugly, ugly preprocessor constructs.

And I hope that my arguments convinced you, too!

Ciao,
Dscho
--1784107012-2103865647-1419332016=:21312--
