From: Johan Herland <johan@herland.net>
Subject: Re: [PATCHv4 02/10] send-pack: Attempt to retrieve remote status even
 if pack-objects fails
Date: Tue, 24 May 2011 00:58:10 +0200
Message-ID: <201105240058.10974.johan@herland.net>
References: <1306111923-16859-1-git-send-email-johan@herland.net>
 <1306111923-16859-3-git-send-email-johan@herland.net>
 <7vei3puqp2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 24 00:58:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOe4p-00019X-Gx
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 00:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757698Ab1EWW6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 18:58:14 -0400
Received: from smtp.getmail.no ([84.208.15.66]:41486 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757650Ab1EWW6O (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 18:58:14 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLO00BG07T03140@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Tue, 24 May 2011 00:58:12 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 5985B1EA559C_DDAE684B	for <git@vger.kernel.org>; Mon,
 23 May 2011 22:58:12 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 386711EA2B83_DDAE683F	for <git@vger.kernel.org>; Mon,
 23 May 2011 22:58:11 +0000 (GMT)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LLO001J97SZFO00@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 24 May 2011 00:58:11 +0200 (MEST)
User-Agent: KMail/1.13.7 (Linux/2.6.38-ARCH; KDE/4.6.3; x86_64; ; )
In-reply-to: <7vei3puqp2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174286>

On Monday 23 May 2011, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > @@ -339,25 +339,18 @@ int send_pack(struct send_pack_args *args,
> > 
> >  	}
> >  	
> >  	if (new_refs && cmds_sent) {
> > 
> > -		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
> > -			for (ref = remote_refs; ref; ref = ref->next)
> > -				ref->status = REF_STATUS_NONE;
> > +		if ((ret = pack_objects(out, remote_refs, extra_have, args))) {
> 
> I am not very familiar with this codepath, but you no longer set
> ref->status to REF_STATUS_NONE ...
> 
> > ...
> > 
> >  	if (status_report && cmds_sent)
> > 
> > -		ret = receive_status(in, remote_refs);
> > -	else
> > -		ret = 0;
> > +		ret |= receive_status(in, remote_refs);
> 
> ... before calling receive_status() here, and that function can return
> early without setting anything.
> 
> Would that have any negative effect on the code that comes after this
> part in the codepath?  or if receive_status() returns a failure, we do
> not even look at ref->status?

Hmm... I believe I proved the correctness of this to myself when I first 
wrote the patch, but looking at it a second time, I see that I only did so 
for send_pack() itself. The remote_refs (that no longer has each ref->status 
set to REF_STATUS_NONE on pack_objects() failure) are given as an argument 
to send_pack(), and are still used by the caller after send_pack() has 
returned (even when it returns with errors).

Therefore, I was wrong to remove this "ref->status = REF_STATUS_NONE" loop. 
Will be fixed in the next iteration.


Thanks for noticing,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
