From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] lookup_object: split up displacement penalty for hash collisions
Date: Fri, 16 Aug 2013 10:28:40 +0200
Message-ID: <87haeqdop3.fsf@linux-k42r.v.cablecom.net>
References: <1376595306-6335-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, <peff@peff.net>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 10:28:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAFOt-0001ib-2C
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 10:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753365Ab3HPI2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 04:28:46 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:35842 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752560Ab3HPI2n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 04:28:43 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 16 Aug
 2013 10:28:37 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Fri, 16 Aug 2013 10:28:40 +0200
In-Reply-To: <1376595306-6335-1-git-send-email-stefanbeller@googlemail.com>
	(Stefan Beller's message of "Thu, 15 Aug 2013 21:35:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232402>

Stefan Beller <stefanbeller@googlemail.com> writes:

> A little background on hash tables first:
> Consider you want to have the object X, which you'd expect at position
> i, but because that place was already taken by B, it is not found at
> position i, you start looking right of position i to find X until you
> find it.
>
>     index       | i-1 |  i  | i+1 | i+2 | i+3 | i+4 |
>            --------------------------------------------
>     entry   ... |  A  |  B  |  C  |  D  |  E  |  X  | ...
>            --------------------------------------------
>
> Once you have found X at i+4, the commit 9a414486d9f0 (2013-05-01,
> lookup_object: prioritize recently found objects) did an optimization
> and swapped the object B with X, so the placement looks like
>
>     index       | i-1 |  i  | i+1 | i+2 | i+3 | i+4 |
>            --------------------------------------------
>     entry   ... |  A  |  X  |  C  |  D  |  E  |  B  | ...
>            --------------------------------------------
[...]
> If we now want to find X and X is expected at i, we put X to
> the position i and B to the middle position between B and X at D
> and D will go to the old position of X:
>
>     index       | i-1 |  i  | i+1 | i+2 | i+3 | i+4 |
>            --------------------------------------------
>     entry   ... |  A  |  X  |  C  |  B  |  E  |  D  | ...
>            --------------------------------------------
>
> So let's test how it works out:
> 	# running the current git.git master (c1ebd90c832e), repeat 25 times:
> 	perf stat -r 25 -- ./git-rev-list --all --objects >/dev/null
> 	...
> 	5.294512141 seconds time elapsed    ( +-  7.88% )
> 	# Now running with this patch applied:
> 	5.111576725 seconds time elapsed    ( +-  8.17% )
[...]
> However please do check if this patch brings the promised performance
> on your own, as you're likely using different hardware and another
> software setup. Feel free to share your performance differences.

I get this on an i7-M620 laptop from t/perf/p0001-rev-list.sh:

  Test                               HEAD                next                    
  -------------------------------------------------------------------------------
  0001.1: rev-list --all             6.29(6.03+0.22)     6.33(6.06+0.24) +0.6%   
  0001.2: rev-list --all --objects   53.22(52.48+0.54)   54.90(54.15+0.55) +3.2%*
  -------------------------------------------------------------------------------
  Significance hints:  '.' 0.1  '*' 0.05  '**' 0.01  '***' 0.001

And this on a newer i7-3930K workstation:

  Test                               HEAD                next                    
  -------------------------------------------------------------------------------
  0001.1: rev-list --all             3.86(3.71+0.14)     3.89(3.74+0.14) +0.7%*  
  0001.2: rev-list --all --objects   30.23(29.91+0.29)   30.35(30.04+0.29) +0.4%.
  -------------------------------------------------------------------------------
  Significance hints:  '.' 0.1  '*' 0.05  '**' 0.01  '***' 0.001

That's using linux.git as a test repository, I figured the numbers were
too small with git.git.

I trust the laptop numbers less because it has far more thermal (and
thus throttling) issues, but the runs do show a significant difference,
though less than you claimed.

> @@ -90,9 +90,27 @@ struct object *lookup_object(const unsigned char *sha1)
>  		 * Move object to where we started to look for it so
>  		 * that we do not need to walk the hash table the next
>  		 * time we look for it.
> +		 * However, we don't want to penalize the the object being
> +		 * moved from the first position, so divide the penalty to
> +		 * two different objects.
>  		 */
> +
> +		/*
> +		 * First make sure i > first, so the middle is really
> +		 * in between the i and first object
> +		 */
> +		if (i < first)
> +			i += obj_hash_size;
> +
> +		middle = (i + first) / 2;
> +		if (i >= obj_hash_size)
> +			i -= obj_hash_size;
> +		if (middle >= obj_hash_size)
> +			middle -= obj_hash_size;
> +
>  		struct object *tmp = obj_hash[i];

Adding all the code above means that this declaration is now in the
middle of things, which is not valid C90.  Please move the declaration
to the beginning of the block, and compile with
-Wdeclaration-after-statement to notice this issue.

> -		obj_hash[i] = obj_hash[first];
> +		obj_hash[i] = obj_hash[middle];
> +		obj_hash[middle] = obj_hash[first];
>  		obj_hash[first] = tmp;
>  	}
>  	return obj;

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
