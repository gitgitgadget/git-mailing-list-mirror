From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: cg-clone, tag objects and cg-push/git-push don't play nice
Date: Wed, 19 Oct 2005 21:10:26 +1300
Message-ID: <46a038f90510190110g53c90c5t419ad6065292269e@mail.gmail.com>
References: <46a038f90510182338k6d3d52fbyc2057e9b775d5b14@mail.gmail.com>
	 <7vzmp6dlii.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 10:11:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES91s-0002AK-89
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 10:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVJSIK2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 04:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVJSIK2
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 04:10:28 -0400
Received: from qproxy.gmail.com ([72.14.204.198]:27010 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932194AbVJSIK1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 04:10:27 -0400
Received: by qproxy.gmail.com with SMTP id v40so29413qbe
        for <git@vger.kernel.org>; Wed, 19 Oct 2005 01:10:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=km2lIE4tMkwjeE9zjqepCEuOUk6Zxnna7b9w1j4FZvnk30Xaxl+UZww3ErJpMyviTw6EGahZfe5i2I9VanU1XXTB0kPDP9yM630GvQtMpOqdtDbBkAvGof5IQdeNvsbT0xGRfG7TJxSXkJjRC5RWlJVEfVVf0hKiPi2IMMvCf9M=
Received: by 10.65.22.20 with SMTP id z20mr302396qbi;
        Wed, 19 Oct 2005 01:10:26 -0700 (PDT)
Received: by 10.64.232.18 with HTTP; Wed, 19 Oct 2005 01:10:26 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmp6dlii.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10270>

On 10/19/05, Junio C Hamano <junkio@cox.net> wrote:
> Martin Langhoff <martin.langhoff@gmail.com> writes:
>
> >  + git-push is trying to walk all the refs it knows about when it does
> > the "what do I have that the repo doesn't" part, and it breaks on
> > those incomplete tag fetches.
>
> That is expected.

Hmmm. I was under the impression that if I call git-push naming a
particular head, it could restrict itself to the stuff needed for that
head only. Just to clarify, I'm running

  git-push locke.catalyst.net.nz:/var/git/moodle-test.git master:mdl-topnz-prod

> Although I do not follow Cogito development closely, I seem to
> recall that it fetched tags without making them complete at some
> point in the past; I hope it is now fixed but I am not sure.

It isn't fixed, but I'm trying to address that one :-p

> I do not understand why removing .git/refs/tags/* did not help,
> and that is the biggest thing that disturbs me in this whole
> problem report

I can't understand that either, but I manually removed all the
refs/tags, and the only heads I have are origin and master. git-push
won't let me do it until the exact point where I have removed the
object from the repo. And that's only possible on unpacked repos.

> Maybe there are some other files
> under .git/refs/ directory that had copies of them?

No. I run a test again, to make sure. Removing .git/refs/tags is not
enough, and the only refs available are origin and master.

I've come up with this awful script to resolve it, while I try to fix cg-fetch:

#usr/bin/perl -w

use strict;

my @refs = `ls .git/refs/tags`;

foreach my $ref (@refs) {
  chomp $ref;
  print "testing for a commit linked from $ref\n";
  my $commit = `git-rev-parse --verify "$ref"^{commit} 2>/dev/null`;
  if ($?) {
    # this one didn't even have a tag ref pointing to a commit!
    #unlink ".git/refs/tags/$ref"
    #  or die "cannot remove .git/refs/tags/$ref";
    #next;
  }

  # thest that we actually have the commit object...
  chomp $commit;
  my $file = `git-cat-file commit $commit  2>/dev/null`;
  if ($?) {
    # could not find the commit object, we better get rid of the
    # tagref and tagobj
    my $tagsha = `git-rev-parse --verify "$ref"  2>/dev/null`;

    chomp $tagsha;
    if ($tagsha) {
      # doublecheck it is a tag
      my $type = `git-cat-file -t $tagsha  2>/dev/null`;
      chomp $type;
      if ($type eq 'tag') {
        my $fileobj = ".git/objects/" . substr($tagsha,0,2) . '/' .
substr($tagsha,2);
        print " removing $fileobj for ref $ref tagsha $tagsha \n";
        `rm -f $fileobj`;
        unlink  ".git/refs/tags/$ref";
      }
    }
  }
}

cheers,


m
