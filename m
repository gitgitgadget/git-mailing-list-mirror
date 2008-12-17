From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: Git Notes idea.
Date: Wed, 17 Dec 2008 11:06:15 -0600
Message-ID: <5d46db230812170906h7fdcac03o60386504c8df1083@mail.gmail.com>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com>
	 <20081216085108.GA3031@coredump.intra.peff.net>
	 <5d46db230812161043m4a5873a8w4c323d634b639ba0@mail.gmail.com>
	 <20081217093843.GA18265@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 17 18:08:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCzs9-0005gP-PW
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 18:07:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbYLQRGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 12:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbYLQRGS
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 12:06:18 -0500
Received: from rn-out-0910.google.com ([64.233.170.186]:55194 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbYLQRGR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 12:06:17 -0500
Received: by rn-out-0910.google.com with SMTP id k40so3070441rnd.17
        for <git@vger.kernel.org>; Wed, 17 Dec 2008 09:06:15 -0800 (PST)
Received: by 10.150.189.9 with SMTP id m9mr1662889ybf.231.1229533575492;
        Wed, 17 Dec 2008 09:06:15 -0800 (PST)
Received: by 10.151.135.7 with HTTP; Wed, 17 Dec 2008 09:06:15 -0800 (PST)
In-Reply-To: <20081217093843.GA18265@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103363>

On Wed, Dec 17, 2008 at 3:38 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Dec 16, 2008 at 12:43:55PM -0600, Govind Salinas wrote:
>
>> I was thinking I would do my first implementation in pyrite and if I find
>> that it works well I will port it.
>
> OK, though your performance will probably suck unless you dump the notes
> tree into a local hash at the beginning of your program. And looking up
> every commit's note during revision traversal is one of the intended
> uses (e.g., decorating git-log output, or filtering commits based on a
> particular note).

Yes, I was thinking that this is the natural way to do things, save that I
would be lazy loading the trees into a cache instead of caching them
all up front.  This is one of the reasons that I think the fan out will
help.

> And as Dscho mentioned, most of what you need is already there in C.
> You are welcome to implement whatever you want in pyrite, of course, but
> there is a desire to have this accessible to the revision traversal
> machinery. And that means if you want your version in pyrite to be
> compatible with what ends up in git, the data structure design needs to
> be suitable for both.

Yes, I completely agree that I want it to have the same scheme as what
git will use.  That is the reason I posted this here.  Since no method
has been formally accepted (checked into master) I wanted to see if
I could nudge things along.  I wasn't aware that you and Dscho had
a (very similar) plan.  Please, if you guys are decided on the format
then I can just go off and start working on it.  But it sounds like there
isn't consensus yet.

<snip>
>> root/
>>      12/
>>          34567890123456789012345678901234567890/
>>              abcdef7890123456789012345678901234567890
>>
>> This way all the notes are attached to a tree, so that gc won't
>> think they are unreferenced objects.
>
> But you have lost the ordering in your list, then, since they will not
> be ordered by sha1 of the note contents. I don't know if you care. The
> second sha1 is pointless, anyway, since nobody will know that number as
> a reference; why not just name them monotonically starting at 1?

In a later mail I suggested that this be the type or name of the note.  Which
I hear is similar to what you suggested.

> One of the things I don't like about having several notes is that it
> introduces an extra level of indirection that every user has to pay for,
> whether they want it or not. If a note can be a blob _or_ a tree, then
> those who want to use blobs can reap the performance benefit. Those who
> want multiple named notes in a hierarchy can pay the extra indirection
> cost.
>
> I haven't measured how big a cost that is (but bearing in mind that we
> might want to do this lookup once per revision in a traversal, even one
> extra object lookup can have an impact).

That seems reasonable.

> I'm also still not convinced the fan-out is worthwhile, but I can see
> how it might be. It would be nice to see numbers for both.
>
<snip>
> Also, how large do you expect the list to be under reasonable
>> circumstances.
>
> As many notes as there are commits is my goal (e.g., it is not hard to
> imagine an automated process to add notes on build status). Ideally, we
> could handle as many notes as there are objects; I see no reason not to
> allow annotating arbitrary sha1's (I don't know if there is a use for
> that, but the more scalable the implementation, the better).

Ah, that is in line with what I was thinking as well.

>> >  Some thoughts from me on naming issues:
>> >  http://article.gmane.org/gmane.comp.version-control.git/100402
>>
>> On naming.  I strongly support a ref/notes/sha1/sha1 approach.  If
>> having a type to the note is important, then perhaps the first line of
>> a note could be considered a type or a set of "tags".  This way you
>
> I don't think we are talking about the same thing. What I mean by naming
> is "here is a shorthand for referring to notes" that is not necessarily
> coupled with the implementation. That is, I would like to do something
> like:
>
>  git log --notes-filter="foo:bar == 1"
>
> and have that "foo:bar" as a shorthand on each commit for:
>
>  refs/notes/foo:$COMMIT/bar
>
> Without a left-hand side (e.g., "bar"), we get:
>
>  refs/notes/default:$COMMIT/bar
>
> Or without a right-hand side (e.g., "foo:"), we get:
>
>  refs/notes/foo:$COMMIT
>

I like the overall plan, but I would suggest that --notes[=default] and
--note-type=whatever would be a little friendlier and less error prone.

Thanks for helping me think through this.

-Govind
