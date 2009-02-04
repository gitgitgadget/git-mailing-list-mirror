From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: [PATCH v2 1/2] Introduce config variable "diff.primer"
Date: Tue, 3 Feb 2009 22:36:48 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0902032217380.25760@kiwi.cs.ucla.edu>
References: <1233598855-1088-1-git-send-email-keith@cs.ucla.edu> <1233598855-1088-2-git-send-email-keith@cs.ucla.edu> <20090203071516.GC21367@sigill.intra.peff.net> <alpine.GSO.2.00.0902030833250.5994@kiwi.cs.ucla.edu>
 <7v7i4692p4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 04 07:39:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUbQ8-0004Oc-C9
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 07:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbZBDGiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 01:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbZBDGiA
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 01:38:00 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:54379 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbZBDGiA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 01:38:00 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n146anoc026521;
	Tue, 3 Feb 2009 22:36:49 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n146amNt026518;
	Tue, 3 Feb 2009 22:36:48 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <7v7i4692p4.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108299>

On Tue, 3 Feb 2009, Junio C Hamano wrote:

> Any codepath could call DIFF_OPT_SET()/CLR(), whether it is in response to end 
> user's input from the command line (e.g. "the user said --foo, so I am 
> flipping the foo bit on/off), or to enforce restriction to achieve sane 
> semantics (e.g. "it does not make any sense to run this internal diff without 
> --binary set, so I am using OPT_SET()").

Yes but the trick is the flips and maskings happen on different structs.  We 
accumulate the shell command line flags/masks in a separate struct from the 
primer flags/masks.  IOW, there's a whole lotta flags and masks!!

> Doesn't it suggest that you may want two layers of masks, not a flat one, if 
> you really want the mechanism to scale?

There are indeed two layers of masks (and there can be as many as needed).  In 
my current patch, the shell command line becomes "master" and primer becomes 
"slave".  Both layers exist independently of each other, in two separate 
diff_option structs, until just before "go time", when I flatten them (but that 
does not destroy the slave, it is reused).  As Peff put it: "a master/slave pair 
of flag/mask pairs".  I specifically designed the code to make it easy to create 
an arbitrary number of layers, then flatten them all together just before it's 
time to do something.  The code only needs to keep track of the order of 
precedence, i.e. always pass the higher precedence struct to 
flatten_diff_options() as master and the lower precedence struct as slave, and 
the bit logic in that function does the rest.  I was specifically thinking of 
GIMP or Photoshop when I wrote this patch.  The concept is the same.  Those 
programs support an arbitrary number of layers, and when they produce the final 
image, they call it "flatten layers".

If you and Peff like this design then I could clean up everything based on all 
of Peff's suggestions (i.e. xmalloc instead of malloc, etc) and hopefully move 
on to the stage of building consensus for the actual name.  No rush of course.  
Just give me the word.  Peff?

                                      -- Keith
