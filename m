From: Mike Hommey <mh@glandium.org>
Subject: Re: Is there interest in a n-sect tool?
Date: Tue, 19 Jan 2016 13:57:19 +0900
Message-ID: <20160119045719.GA11680@glandium.org>
References: <20160118075653.GA13911@glandium.org>
 <xmqq1t9fe0qw.fsf@gitster.mtv.corp.google.com>
 <20160118085835.GA15642@glandium.org>
 <xmqqziw2b4wi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 05:58:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLOMp-00027T-B8
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 05:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757240AbcASE5a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2016 23:57:30 -0500
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40256 "EHLO
	glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755875AbcASE53 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2016 23:57:29 -0500
Received: from glandium by zenigata with local (Exim 4.86)
	(envelope-from <mh@glandium.org>)
	id 1aLOM3-00035X-Nr; Tue, 19 Jan 2016 13:57:19 +0900
Content-Disposition: inline
In-Reply-To: <xmqqziw2b4wi.fsf@gitster.mtv.corp.google.com>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284347>

On Mon, Jan 18, 2016 at 07:54:21PM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > On Mon, Jan 18, 2016 at 12:43:35AM -0800, Junio C Hamano wrote:
> > ...
> >> two).  If you have three states, black/gray/white, that linearly
> >> transitions states twice (i.e. one part of the history is
> >> continuously black, and at one boundary it turns gray and continues
> >> to be gray, until at another boundary it turns white and continues
> >> to be white to the other end), you would still "bi"-sect to find
> >> these two transition points....
> >> ...  Is that the kind of search you are talking about?
> >
> > Yes, it is. Somehow, I was thinking of the result once you're done
> > bisecting, not the process itself of cutting history in two parts.
> 
> I am not sure what you meant by "Yes it is"; is the above (i.e. in a
> history whose one part is painted continuously in black, one part
> continuously in gray and the remainder in white where white and
> black never touch, find the transition between black and gray and
> the transition between gray and white) the kind of search you are
> talking about?  Judging from the remainder of your message, I had an
> impression that you are solving a different problem where you want
> to find transitions for N distinct traits (i.e. 2^N combinations,
> not N distinct colors like black-gray-white).

No, I'm really after N distinct colors, where I don't know N in advance.
> 
> > That being said, while I can do these things locally with my own
> > scripts, as a user, I would have found it useful if git bisect (and
> > especially git bisect run) would support this out of the box. The
> > question remains whether it would be useful to more people than
> > just me.
> 
> Hmm, sorry.  For the two-trait example I gave (that can be extended
> to N-trait), I can sort of see how the UI might look and I can say
> it might be useful [*1*], but not with this, and especially that you
> do not necessarily know all the traits whose transition points you
> might be interested in a-priori--all of that makes the problem
> definition fuzzy to me, and I cannot imagine what kind of user
> interaction you would be envisioning to solve what kind of problem,
> so I cannot even say it is a good idea or a bad idea.

How about something like this:

$ git bisect start
$ git bisect state black A
$ git bisect state white Z

Git then gives you commit M to test, between A and Z. Now, you test M,
and the result is that it's neither black or white, but gray, so you
would do:

$ git bisect state gray

Git then gives you commit G, between A and M, which you test, and it's
gray. So the state map, as of now is:

A - black
G - gray
M - gray
Z - white

As of now, Git is still looking for the first gray, so it gives you
commit D, between A and G, etc. until you find the first gray.

Once we're done finding the first gray, Git now wants you to find the
first black, so goes back to bisecting between M and Z.

Once all transitions are found, it outputs something like:
<sha1> is the first gray commit
$(git diff-tree --pretty <sha1>)

<sha1_2> is the first white commit
$(git diff-tree --pretty <sha1_2>)

At any point, there could be additional intermediate states that we
find, in which case Git would bisect them.

How does that sound?

Mike
