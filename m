From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH 1/3] Add git-send-email-script - tool to send emails from git-format-patch-script
Date: Sun, 31 Jul 2005 19:52:42 -0400
Message-ID: <20050731235242.GH32263@mythryan2.michonline.com>
References: <11227978451100@foobar.com> <7vbr4jmhqe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 01:53:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzNc3-0006e7-EL
	for gcvg-git@gmane.org; Mon, 01 Aug 2005 01:52:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVGaXws (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 19:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVGaXws
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 19:52:48 -0400
Received: from mail.autoweb.net ([198.172.237.26]:37252 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S262143AbVGaXwo (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2005 19:52:44 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DzNbn-0008Iz-0Z; Sun, 31 Jul 2005 19:52:43 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DzNlb-00034g-00; Sun, 31 Jul 2005 20:02:51 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DzNbm-0000nQ-F2; Sun, 31 Jul 2005 19:52:42 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbr4jmhqe.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 31, 2005 at 02:45:29AM -0700, Junio C Hamano wrote:
> Ryan Anderson <ryan@michonline.com> writes:
> 
> > 	All emails are sent as a reply to the previous email, making it easy to
> > 	skip a collection of emails that are uninteresting.
> 
> I understand why _some_ people consider this preferable, but
> wonder if this should have a knob to be tweaked.

Hmm, fair enough.

I'll send a few more patches in a minute that deal with the things in
this email but for now:

	--chain-reply-to (or --no-chain-reply-to)

	Will toggle between these two behaviors.  (This will not be
	prompted for by the ReadLine interface, btw.)

> > +# horrible hack of a script to send off a large number of email messages, one after
> > +# each other, all chained together.  This is useful for large numbers of patches.
> > +#
> > +# Use at your own risk!!!!
> 
> Well, if it is "Use at your own risk" maybe it should stay
> outside the official distribution for a while until it gets
> safer ;-).

Heh.  I missed some comments that I meant to clean up that were in
Greg's original script.  One of the patches will clean up the comments.

> > +	my @fields = split /\s+/, $data;
> > +	my $ident = join(" ", @fields[0...(@fields-3)]);
> 
> Wouldn't "s/>.*/>/" be easier than splitting and joining?

Most of GIT_COMMITTER_IDENT (and GIT_AUTHOR_IDENT) is use controllable,
except for the "date" section of it.  I know we delimit that with
spaces, so the above is guaranteed to work unless we change the format
that git-var returns.

If I hope that nobody has done something like:
	GIT_AUTHOR="Ryan <> Anderson"
	GIT_AUTHOR_EMAIL="ryan@michonline.com"

I get more confusing results.  (I suddenly have to think about what that
regular expression does in this case - and I'm pretty sure that the one
you gave would do bad things.)

Probably the best fix for this would be to take libgit.a, make a shared
library out of it, and then interface the Perl scripts directly with it
via a .xs module.  I was thinking that I'd rather have direct access to
the git_ident* functions than calling out to git-var, anyway.  Consider
that a plan for a revamp after the core seems to have settled down a bit
more.

> > +if (!defined $from) {
> > +	$from = $author || $committer;
> > +	1 while (!defined ($_ = $term->readline("Who should the emails appear to be from? ", 
> > +				$from)));
> 
> Judging from your past patches, you seem to really like
> statement modifiers[*].  While they _are_ valid Perl constructs,
> it is extremely hard to read when used outside very simple
> idiomatic use.  Please consider rewriting the above and the like
> using compound statements[*] (I am using these terms according
> to the definition in perlsyn.pod).  Remember, there are people
> Perl is not their native language, but are intelligent enough to
> be of great help fixing problems in programs you write in Perl.
> To most of them, compound statements are more familiar, so try
> to be gentle to them.

I copied this from another program of mine, and I'm *sure* I copied the
style directly from a ReadLine example.  But, I can't find a current
example that says this is good, so, I'll fix this, too.  It is rather
ugly.  (The other uses of this style are... less bad, IMO, than this
abuse here.)


> 
> > +		opendir(DH,$f)
> > +			or die "Failed to opendir $f: $!";
> > +		push @files, map { +$f . "/" . $_ } grep !/^\.{1,2}$/,
> > +			sort readdir(DH);
> 
> Maybe skip potential subdirs while you are at it, something like this?
> 
>     push @files, sort grep { -f $_ } map { "$f/$_" } readdir(DH)

Good point.  One one hand I'd say, "Let it break for people who do
strange things like that", but I'll make it safer anyway.

(Someone is going to reply and ask for it to recurse into subdirectories
now.  Maybe Andrew Morton would find that useful with his rather massive
collection of patches in -mm kernels.  But that's a feature for next
week.)

> > +	my $pseudo_rand = int (rand(4200));
> > +	$message_id = "<$date$pseudo_rand\@foobar.com>";
> > +	print "new message id = $message_id\n";
> 
> I doubt this hardcoded foobar.com is a good idea.  Did you mean
> to print it, by the way?

I'll convert this to something that is based off the $from address
instead.  It's probably better that way, anyway.

> > +	$to{lc(Email::Valid->address($_))}++ for (@to);
> > +	my $to = join(",", keys %to);
> 
> Is this the culprit that produced this mechanical-looking line?
> 
>     To: junkio@cox.net,git@vger.kernel.org

No, that line was exactly what I put into the readline entry.

> Interestingly enough, you do not seem to do it for the From:
> line.
> 
>     From: Ryan Anderson <ryan@michonline.com>
> 
> Also you seem to be losing the ordering in @to and @cc by the
> use of uniquefying "keys %to" and "keys %cc".  I can not offhand
> tell if it matters, but you probably would care, at least for
> the primary recipients listed in @to array.

Well, it was kind of annoying to see the same email address appear 2-3
times in the email, because of the way I pull in all the relevant emails
from various places.  So I really needed a way to cull the duplicates.
I don't believe ordering is really significant in To: or Cc: lines, for
really anyone.  I could do soemthing like this, instead, I suppose:

	my @clean_to = ();
	my %dupe_check_to = ();
	foreach my $to_entry (@to) {
		if (!$dupe_check_to{Email::Valid->address($to_entry)}++) {
			push @clean_to, $to_entry;
		}
	}

	my $to = join(", ", @clean_to);

I just like the first one a little better (though, I can't really pin
down why).

> > +	$mail{smtp} = 'localhost';
> 
> I suspect this probably need to be configurable.  I may be a
> minority, but my outgoing messages are directly handed to my
> local ISP smtp server from my MUA, and the smtp server running
> on the locahost does not talk to the outside world.

Oddly, I think this is even the wrong setting after having read over the
Mail::Sendmail docs to figure out how to change the MIME settings.

> Since there are always 47 different ways to do the same thing in
> Perl, Perl style varies a lot more than Shell style which in
> turn varies a lot more than C.  You should be prepared to be
> nitpicked a lot when you post Perl ;-).  And I was in nitpicking
> mood tonight.

It's Perl.  There does seem to be a lot of nitpicking when people write
Perl.

(If you write it in idiomatic Perl, the non-Perl users hate you.  If you
write it like C, the Perl users complain that you write it like C.
*sigh*)

> Thanks for the patch.  Overall, very good intent.  Slightly
> troublesome details.

Thanks.

I'll have a series of patches out in a few minutes that will update what
I originally sent to fix your issues here.

-- 

Ryan Anderson
  sometimes Pug Majere
