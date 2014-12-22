From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 04/18] Offer a function to demote fsck errors to
 warnings
Date: Mon, 22 Dec 2014 22:43:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1412222232270.21312@s15462909.onlinehome-server.info>
References: <cover.1418055173.git.johannes.schindelin@gmx.de> <2a0c4cd4c5d3aaceff8a6ffa49d2f3597d26086d.1418055173.git.johannes.schindelin@gmx.de> <xmqqoarbidv7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 22:43:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3AlJ-0008U3-0Z
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 22:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755705AbaLVVn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 16:43:29 -0500
Received: from mout.gmx.net ([212.227.17.21]:62394 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755135AbaLVVn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 16:43:28 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0MMoU7-1XyUr71HvL-008aJN;
 Mon, 22 Dec 2014 22:43:22 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqoarbidv7.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:owpXiSuBmyT8xBW5Se1YryFPO4+vdDLWY6TIMUiJT+QdcBf4x9t
 IEv4f87kVG5sEHDkl/ouhQWVzpQRqGxdiX/wGO/3cd/tpmWe2wH47J51vwdOhL2h81ZKtDg
 dAGvtVrNXF892hWVl9wzPQwOgUPgzlQSkPAKyz+ZmedSQ2K4mVK1GVyppizfgrrSQnVI0Rt
 Mt9P5RmfiHJQcPsZmh6qw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261672>

Hi Junio,

On Wed, 10 Dec 2014, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > There are legacy repositories out there whose older commits and tags
> > have issues that prevent pushing them when 'receive.fsckObjects' is set.
> > One real-life example is a commit object that has been hand-crafted to
> > list two authors.
> >
> > Often, it is not possible to fix those issues without disrupting the
> > work with said repositories, yet it is still desirable to perform checks
> > by setting `receive.fsckObjects = true`. This commit is the first step
> > to allow demoting specific fsck issues to mere warnings.
> >
> > The function added by this commit parses a list of settings in the form:
> >
> > 	missing-email=warn,bad-name=warn,...
> >
> > Unfortunately, the FSCK_WARN/FSCK_ERROR flag is only really heeded by
> > git fsck so far, but other call paths (e.g. git index-pack --strict)
> > error out *always* no matter what type was specified. Therefore, we
> > need to take extra care to default to all FSCK_ERROR in those cases.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  fsck.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  fsck.h |  7 +++++--
> >  2 files changed, 63 insertions(+), 2 deletions(-)
> >
> > diff --git a/fsck.c b/fsck.c
> > index 05b146c..9e6d70f 100644
> > --- a/fsck.c
> > +++ b/fsck.c
> > @@ -97,9 +97,63 @@ static int parse_msg_id(const char *text, int len)
> >  
> >  int fsck_msg_type(enum fsck_msg_id msg_id, struct fsck_options *options)
> >  {
> > +	if (options->strict_mode && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
> > +		return options->strict_mode[msg_id];
> > +	if (options->strict)
> > +		return FSCK_ERROR;
> >  	return msg_id < FIRST_WARNING ? FSCK_ERROR : FSCK_WARN;
> >  }
> 
> Hmm, if you are later going to allow demoting (hopefully also promoting)
> error to warn, etc., would the comparison between msg_id and FIRST_WARNING
> make much sense?

A later patch indeed adds that option. The reason the comparison still
makes sense is that the pure infos do not return at all so far, but all of
the reported warnings are fatal in strict mode (i.e. when
receive.fsckObjects = true). In another later patch it is made possible to
promote even infos (such as 'missing tagger') to warnings or even errors,
and that is when the "return FSCK_ERROR" is changed to "return msg_id <
FIRST_INFO ? FSCK_ERROR : FSCK_WARN".

> In other words, at some point wouldn't we be better off with
> something like this
> 
> 	struct {
>         	enum id;
>                 const char *id_string;
>                 enum error_level { FSCK_PASS, FSCK_WARN, FSCK_ERROR };
> 	} possible_fsck_errors[];

I considered that, and Michael Haggerty also suggested that in a private
mail. However, I find that there is a clear hierarchy in the default
messages: fatal errors, errors, warnings and infos. This should be
reflected by the order IMHO.

But I guess it would make a lot of sense to insert those levels as special
enum values to make it harder to forget to adjust, say, "#define
FIRST_WARNING FSCK_MSG_BAD_FILEMODE" when introducing another warning that
sorts before said ID alphabetically. In other words, I think that we can
really afford to put something like

	...
        FUNC(UNKNOWN_TYPE) \
        FUNC(ZERO_PADDED_DATE) \
        FUNC(___WARNINGS) \
        FUNC(BAD_FILEMODE) \
        FUNC(EMPTY_NAME) \
	...

at the price of making the parsing a little more complicated and wasting a
slight bit of more space for the msg_id_str array.

What do you think?

Ciao,
Dscho
Ciao,
Dscho
