From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Allow git-cvsserver database table name prefix to be
 specified.
Date: Wed, 19 Mar 2008 22:36:53 -0700
Message-ID: <7vwsnyx8ga.fsf@gitster.siamese.dyndns.org>
References: <1205989546855-git-send-email-josh@elsasser.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Frank Lichtenheld <frank@lichtenheld.de>
To: Josh Elsasser <josh@elsasser.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 06:37:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcDTQ-0001CS-Ak
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 06:37:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbYCTFhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 01:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752976AbYCTFhK
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 01:37:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57321 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449AbYCTFhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 01:37:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A40C252A;
	Thu, 20 Mar 2008 01:37:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7C8B32529; Thu, 20 Mar 2008 01:36:58 -0400 (EDT)
In-Reply-To: <1205989546855-git-send-email-josh@elsasser.org> (Josh
 Elsasser's message of "Wed, 19 Mar 2008 22:05:46 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77630>

Josh Elsasser <josh@elsasser.org> writes:

> The purpose of this patch is to easily allow a single database (think
> PostgreSQL or MySQL) to be shared by multiple repositories.

I am not sure if this is even a good idea.  You can share a single
database cluster (in PostgreSQL lingo, I do not recall how MySQL calls it)
and have multiple database instances on it, which would give you better
isolation between repositories.  What's the advantage of your approach, I
have to wonder.

> +gitcvs.dbprefix::

And it would not be dbprefix but table name prefix.  

> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index 7f632af..fe6464f 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -2326,6 +2326,8 @@ sub new
>          $cfg->{gitcvs}{dbuser} || "";
>      $self->{dbpass} = $cfg->{gitcvs}{$state->{method}}{dbpass} ||
>          $cfg->{gitcvs}{dbpass} || "";
> +    $self->{dbprefix} = $cfg->{gitcvs}{$state->{method}}{dbprefix} ||
> +        $cfg->{gitcvs}{dbprefix} || "";

Ok.

> @@ -2334,6 +2336,8 @@ sub new
>                      );
>      $self->{dbname} =~ s/%([mauGg])/$mapping{$1}/eg;
>      $self->{dbuser} =~ s/%([mauGg])/$mapping{$1}/eg;
> +    $self->{dbprefix} =~ s/%([mauGg])/$mapping{$1}/eg;
> +    $self->{dbprefix} = mangle_tablename($self->{dbprefix});

Ok.

> @@ -2349,10 +2353,10 @@ sub new
>      }
>  
>      # Construct the revision table if required
> -    unless ( $self->{tables}{revision} )
> +    unless ( $self->{tables}{"$self->{dbprefix}revision"} )

Hmmm.  If we are going to insist on having multiple tables in a single
database, can we make sure we have better chances of catching mistakes by
doing something like...

    * Identify the set of tables and indices one repository would use
      (i.e. revision, revision_ix1, etc.)

    * Instead of doing things like this:

> -            CREATE TABLE revision (
> +            CREATE TABLE $self->{dbprefix}revision (
> -    my $insert_rev = $self->{dbh}->prepare_cached("INSERT INTO revision (name, revision, filehash, commithash, modified, author, mode) VALUES (?,?,?,?,?,?,?)",{},1);
> +    my $insert_rev = $self->{dbh}->prepare_cached("INSERT INTO $self->{dbprefix}revision (name, revision, filehash, commithash, modified, author, mode) VALUES (?,?,?,?,?,?,?)",{},1);

      Define symbolic name for the full name of tables and indices you
      identified in the previous step to avoid typos.  Perhaps use a per
      GITCVS::updater instance slot $self->{revision_table}, or a method
      that returns these names (so that you would get an empty string and
      blattant SQL statement error if you make typos in your program)?

But I do not have _so_ strong opinion on these.  GITCVS::updater module
seems to abstract the individual access operations (e.g. insert_rev,
insert_mergelog) reasonably well, so perhaps I am worrying too much.
