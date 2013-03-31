From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 9/9] clone: run check_everything_connected
Date: Sun, 31 Mar 2013 14:57:12 +0700
Message-ID: <20130331075712.GA13136@lanh>
References: <20130325201427.GA15798@sigill.intra.peff.net>
 <20130325202627.GI16019@sigill.intra.peff.net>
 <CACsJy8BMfYnFv=PL8x5JOMkjYc39h630oNEdukkjmBKBTNCibg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 31 09:57:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMD92-0004Fa-2L
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 09:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380Ab3CaH5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Mar 2013 03:57:08 -0400
Received: from mail-da0-f53.google.com ([209.85.210.53]:39699 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935Ab3CaH5H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 03:57:07 -0400
Received: by mail-da0-f53.google.com with SMTP id n34so695104dal.12
        for <git@vger.kernel.org>; Sun, 31 Mar 2013 00:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=R3EADpJvyab7J+UVaTF75Eu+boI0g9s1C1kLMtc0RzM=;
        b=OC4J2BVUdpFUyyIIoWyVlaAA0bRTpI4QAgxltbU//wdk6h/3y2S70UXU4lvLxUWeDM
         eDiW0ny1mn6Kmvs2yXWgylbfc4ZEYazCTZ6+bRBpyc9KiFBD50gFShIRFNrnDNfbCV4m
         U+YscuJF72myPwvZv3jdR2HIrFcneMJls2Kyjte/77LEA+TN/T3Y+cdi2l6PER5vj/Kb
         cqQkJqrfyCNgt1aiX7Tj5HjyriEL61+jprRjPBUAo8KfwtySQ7cSvvYbIXCBCwsttRmU
         ZUTQkeF1bPqOEBG2/W15cftvWANp7kH9diwNwz81gpTny1vqW22zyc915Tm+0zpW6fMC
         Zjow==
X-Received: by 10.66.122.97 with SMTP id lr1mr12915596pab.147.1364716626499;
        Sun, 31 Mar 2013 00:57:06 -0700 (PDT)
Received: from lanh ([115.74.58.181])
        by mx.google.com with ESMTPS id ux10sm10417407pab.1.2013.03.31.00.57.02
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 31 Mar 2013 00:57:05 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 31 Mar 2013 14:57:12 +0700
Content-Disposition: inline
In-Reply-To: <CACsJy8BMfYnFv=PL8x5JOMkjYc39h630oNEdukkjmBKBTNCibg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219602>

On Thu, Mar 28, 2013 at 07:40:51AM +0700, Duy Nguyen wrote:
> Maybe we could do it in index-pack to save some (wall) time. I haven't
> tried but I think it might work. The problem is to make sure the pack
> contains objects for all sha1 references in the pack. By that
> description, we don't need to do standard DAG traversal. We could
> extract sha-1 references in index-pack as we uncompress objects and
> put all "want" sha-1 in a hash table. At the end of index-pack, we
> check if any sha-1 in the hash table still points to non-existing
> object.
> 
> This way, at least we don't need to uncompress all objects again in
> rev-list. We could parse+hash in both phases in index-pack. The first
> phase (parse_pack_objects) is usually I/O bound, we could hide some
> cost there. The second phase is multithreaded, all the better.

It looks like what I describe above is exactly what index-pack
--strict does. Except that it holds the lock longer and has more
abstraction layers to slow things down. On linux-2.6 with 3 threads:

$ rev-list --all --objects --quiet (aka check_everything_connected)
34.26user 0.22system 0:34.56elapsed 99%CPU (0avgtext+0avgdata 2550528maxresident)k
0inputs+0outputs (0major+208569minor)pagefaults 0swaps

$ index-pack --stdin
214.57user 8.38system 1:31.82elapsed 242%CPU (0avgtext+0avgdata 1357328maxresident)k
8inputs+1421016outputs (0major+1222537minor)pagefaults 0swaps

$ index-pack --stdin --strict
297.36user 13.77system 2:11.82elapsed 236%CPU (0avgtext+0avgdata 1875040maxresident)k
0inputs+1421016outputs (0major+1308718minor)pagefaults 0swaps

$ index-pack --stdin --connectivity
231.09user 7.42system 1:37.39elapsed 244%CPU (0avgtext+0avgdata 2080816maxresident)k
0inputs+1421016outputs (0major+540069minor)pagefaults 0swaps

The last one does not hold locks by duplicating object hash table per
thread. As you can see the consumed memory is much higher than --stdin.
In return it only adds up 1/3 of rev-list time.

Maybe you should check which one is cheaper for clone case,
check_everything_connected() or index-pack --strict.
--
Duy
