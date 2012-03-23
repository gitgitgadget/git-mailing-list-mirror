From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make 'cvs -n commit ...' not to commit
Date: Fri, 23 Mar 2012 11:39:19 -0700
Message-ID: <7vhaxftb54.fsf@alter.siamese.dyndns.org>
References: <20120323131100.7262D440B33@melkor.giref.ulaval.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: ericc <eric.chamberland@giref.ulaval.ca>
X-From: git-owner@vger.kernel.org Fri Mar 23 19:39:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB9Ob-0004Vz-58
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 19:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759413Ab2CWSjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 14:39:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46776 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753486Ab2CWSjW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 14:39:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FEC877D3;
	Fri, 23 Mar 2012 14:39:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hmZxXZyeggOhRWy2PUo8Aoy0/s0=; b=EGlG8B
	P4hs0UrnxHsYuFZh207FJck8EzuNGk6ccQU9ldmPN8oKnQ7jobnAsFLCdHXBC/3h
	s7uZZPZkHWkFhtBZkltRlVv8dwZrvxi9h2PoO1ji8uiuyisYWx+4g7sstxS9NSlN
	oeZbnYaL7NrwxTe1CTZQ0C7iQjF5RvH9jHWvM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FafLlOU//h+SCVRbdZZ/X4HtKAw4xAqV
	kRGyfMzNU+/aNACcxDOha8CszozFSjNiCWWYUKQ0K5bCzIseLCFyTowsiGsWa5P9
	zQumto/h+udaUCByKHIrpPaD+/KLyNbmGHoBHIxAneqZ4VSSTfV6mktzNVK08vg2
	yYyQ5wrYveA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5668177D2;
	Fri, 23 Mar 2012 14:39:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5E8177D1; Fri, 23 Mar 2012
 14:39:20 -0400 (EDT)
In-Reply-To: <20120323131100.7262D440B33@melkor.giref.ulaval.ca> (ericc's
 message of "Thu, 22 Mar 2012 16:57:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8115D18C-7517-11E1-89D2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193789>

ericc <eric.chamberland@giref.ulaval.ca> writes:

> Actually, doing a 'cvs -n commit' will _do_ the commit...
> With this patch, it now goes through the code, but don't do the commit.

OK.

> A further progress would be to do the pre-commit hook is possible...

It is not clear what you meant here.

> Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>
> ---
>  git-cvsserver.perl |    9 ++++++++-
>  1 files changed, 8 insertions(+), 1 deletions(-)
>
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index b8eddab..67ec4d0 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -1395,6 +1395,9 @@ sub req_ci
>          push @committedfiles, $committedfile;
>          $log->info("Committing $filename");
>  
> +        # Don't want to actually _DO_ the update if -n specified
> +        unless ( $state->{globaloptions}{-n} ) 
> +        {
>          system("mkdir","-p",$dirpart) unless ( -d $dirpart );
>  
>          unless ( $rmflag )
> @@ -1424,6 +1427,7 @@ sub req_ci
>              $log->info("Updating file '$filename'");
>              system("git", "update-index", $filename);
>          }
> +        }
>      }

I understand that you tried to make the patch smaller by avoiding
re-indenting, but this is *yucky*.

It looks to me that the above part could be solved with:

	unless (...) {
		next;
	}

I think the function being patched is too big.  Wouldn't it be better to
have a refactoring patch to move the above per-path logic to a helper
function that deals with a single path, and then insert the "omit call to
that helper when run with -n" code in a separate patch?

The same comment applies to the other hunk.

Also I notice that the indentation used throughout the file is somewhat
broken (e.g. "Emulate by running hooks/update" part is indented to 8
columns, but earlier parts use 4 space indent).  The right structure for
this change may be:

 Patch 1: Fix indentation (and do nothing else) to uniformly indent with
          HT;

 Patch 2: Refactor this big funciton using a handful of helper functions
	  (and do nothing else);

 Patch 3: Omit calls to these helper functions under -n option.


> @@ -1434,6 +1438,9 @@ sub req_ci
>          return;
>      }
>  
> +    # Don't want to actually _DO_ the update if -n specified
> +    unless ( $state->{globaloptions}{-n} ) 
> +    {
>      my $treehash = `git write-tree`;
>      chomp $treehash;
>  
> @@ -1537,7 +1544,7 @@ sub req_ci
>              print "/$filepart/1.$meta->{revision}//$kopts/\n";
>          }
>      }
> -
> +    }
>      cleanupWorkTree();
>      print "ok\n";
>  }
