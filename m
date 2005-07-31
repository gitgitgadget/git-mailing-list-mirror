From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Add git-send-email-script - tool to send emails from git-format-patch-script
Date: Sun, 31 Jul 2005 02:45:29 -0700
Message-ID: <7vbr4jmhqe.fsf@assigned-by-dhcp.cox.net>
References: <11227978451100@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 11:46:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DzAOW-000631-No
	for gcvg-git@gmane.org; Sun, 31 Jul 2005 11:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVGaJpl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Jul 2005 05:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261859AbVGaJpl
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Jul 2005 05:45:41 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:36039 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261651AbVGaJpg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2005 05:45:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050731094530.NYHU3209.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 31 Jul 2005 05:45:30 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <11227978451100@foobar.com> (Ryan Anderson's message of "Sun, 31 Jul 2005 04:17:25 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ryan Anderson <ryan@michonline.com> writes:

> 	All emails are sent as a reply to the previous email, making it easy to
> 	skip a collection of emails that are uninteresting.

I understand why _some_ people consider this preferable, but
wonder if this should have a knob to be tweaked.

For example, I myself often find it very hard to read when
a cascading thread goes very deep like this:

     [PATCH 0/9] cover
       [PATCH 1/9] first one
         [PATCH 2/9] second one
          [PATCH 3/9] third one in the series
            ...

and prefer to see this instead (this assumes your MUA is
half-way decent and lets you sort by subject):

     [PATCH 0/9] cover
       [PATCH 1/9] first one
       [PATCH 2/9] second one
       [PATCH 3/9] third one in the series
       ...

> +# horrible hack of a script to send off a large number of email messages, one after
> +# each other, all chained together.  This is useful for large numbers of patches.
> +#
> +# Use at your own risk!!!!

Well, if it is "Use at your own risk" maybe it should stay
outside the official distribution for a while until it gets
safer ;-).

> +	my @fields = split /\s+/, $data;
> +	my $ident = join(" ", @fields[0...(@fields-3)]);

Wouldn't "s/>.*/>/" be easier than splitting and joining?

> +if (!defined $from) {
> +	$from = $author || $committer;
> +	1 while (!defined ($_ = $term->readline("Who should the emails appear to be from? ", 
> +				$from)));

Judging from your past patches, you seem to really like
statement modifiers[*].  While they _are_ valid Perl constructs,
it is extremely hard to read when used outside very simple
idiomatic use.  Please consider rewriting the above and the like
using compound statements[*] (I am using these terms according
to the definition in perlsyn.pod).  Remember, there are people
Perl is not their native language, but are intelligent enough to
be of great help fixing problems in programs you write in Perl.
To most of them, compound statements are more familiar, so try
to be gentle to them.

> +		opendir(DH,$f)
> +			or die "Failed to opendir $f: $!";
> +		push @files, map { +$f . "/" . $_ } grep !/^\.{1,2}$/,
> +			sort readdir(DH);

Maybe skip potential subdirs while you are at it, something like this?

    push @files, sort grep { -f $_ } map { "$f/$_" } readdir(DH)

> +	my $pseudo_rand = int (rand(4200));
> +	$message_id = "<$date$pseudo_rand\@foobar.com>";
> +	print "new message id = $message_id\n";

I doubt this hardcoded foobar.com is a good idea.  Did you mean
to print it, by the way?

> +	$to{lc(Email::Valid->address($_))}++ for (@to);
> +	my $to = join(",", keys %to);

Is this the culprit that produced this mechanical-looking line?

    To: junkio@cox.net,git@vger.kernel.org

Interestingly enough, you do not seem to do it for the From:
line.

    From: Ryan Anderson <ryan@michonline.com>

Also you seem to be losing the ordering in @to and @cc by the
use of uniquefying "keys %to" and "keys %cc".  I can not offhand
tell if it matters, but you probably would care, at least for
the primary recipients listed in @to array.

> +	$mail{smtp} = 'localhost';

I suspect this probably need to be configurable.  I may be a
minority, but my outgoing messages are directly handed to my
local ISP smtp server from my MUA, and the smtp server running
on the locahost does not talk to the outside world.

> +	# set up for the next message
> +	$reply_to = $message_id;

Making chaining policy configurable would be just one liner
change here, I suppose.

Since there are always 47 different ways to do the same thing in
Perl, Perl style varies a lot more than Shell style which in
turn varies a lot more than C.  You should be prepared to be
nitpicked a lot when you post Perl ;-).  And I was in nitpicking
mood tonight.

Thanks for the patch.  Overall, very good intent.  Slightly
troublesome details.

-jc
