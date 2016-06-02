From: Eric Wong <e@80x24.org>
Subject: Re: [PATCH 1/3] pretty: support "mboxrd" output format
Date: Thu, 2 Jun 2016 07:51:25 +0000
Message-ID: <20160602075125.GA19551@dcvr.yhbt.net>
References: <20160530232142.21098-1-e@80x24.org>
 <20160530232142.21098-2-e@80x24.org>
 <CAPig+cQrSJe03_RtSyf5KO2vE3Rri7t70-he8SXA9Y4oBYY_Ww@mail.gmail.com>
 <20160531074506.GA8911@dcvr.yhbt.net>
 <CAPig+cQrQfxWrGhpvtb-GKYfK0tMLsx9JJ+eWRRx00F8mNXrLg@mail.gmail.com>
 <20160531182932.GA27021@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 09:51:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8NPg-0001rQ-T8
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 09:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbcFBHv2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 03:51:28 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35486 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932188AbcFBHv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 03:51:26 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E5371F992;
	Thu,  2 Jun 2016 07:51:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160531182932.GA27021@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296188>

Eric Wong <e@80x24.org> wrote:
> Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Tue, May 31, 2016 at 3:45 AM, Eric Wong <e@80x24.org> wrote:
> > > Eric Sunshine <sunshine@sunshineco.com> wrote:
> > >> I wonder if hand-coding, rather than using a regex, could be an improvement:
> > >>
> > >>     static int is_mboxrd_from(const char *s, size_t n)
> > >>     {
> > >>         size_t f = strlen("From ");
> > >>         const char *t = s + n;
> > >>
> > >>         while (s < t && *s == '>')
> > >>             s++;
> > >>         return t - s >= f && !memcmp(s, "From ", f);
> > >>     }
> > >>
> > >> or something.
> > >
> > > Yikes.  I mostly work in high-level languages and do my best to
> > > avoid string parsing in C; so that scares me.  A lot.
> > 
> > The hand-coded is_mboxrd_from() above is pretty much idiomatic C and
> > (I think) typical of how such a function would be coded in Git itself,
> > so it looks normal and easy to grok to me (but, of course, I'm
> > probably biased since I wrote it).

For reference, here is the gfrom function from qmail (gfrom.c,
source package netqmail-1.06 in Debian, reformatted git style)

int gfrom(char *s, int len)
{
	while ((len > 0) && (*s == '>')) {
		++s;
		--len;
	}

	return (len >= 5) && !str_diffn(s, "From ", 5);
}

Similar to yours, but a several small things improves
readability for me:

* the avoidance of subtraction from the "return" conditional
* s/n/len/ variable name
* extra parentheses
* removal of "t" variable (t for "terminal/termination"?)

str_diffn is memcmp-like, I assume.  My eyes glazed over
when I saw that function implemented in str_diffn.c, too.

Just thinking out loud, with sufficient tests I could go with
either.  Will reroll when/if I get the chance tomorrow.
