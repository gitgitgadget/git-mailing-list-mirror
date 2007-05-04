From: "Dana How" <danahow@gmail.com>
Subject: Re: [RFD/PATCH] Implement pack.compression and pack-objects --compression=N
Date: Fri, 4 May 2007 09:10:38 -0700
Message-ID: <56b7f5510705040910i3cac723co3aed45034c097def@mail.gmail.com>
References: <463802ED.1080200@gmail.com>
	 <7vk5vr3w8n.fsf@assigned-by-dhcp.cox.net>
	 <56b7f5510705021155k40b576d6ke286e65494fc8b05@mail.gmail.com>
	 <56b7f5510705021551q2d48f1e5i3f4a5c2f9891368a@mail.gmail.com>
	 <7vejlxxho1.fsf@assigned-by-dhcp.cox.net>
	 <alpine.LFD.0.99.0705040937250.24220@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>, danahow@gmail.com
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri May 04 18:11:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hk0N6-0002bp-Dt
	for gcvg-git@gmane.org; Fri, 04 May 2007 18:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031060AbXEDQKl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 May 2007 12:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031080AbXEDQKl
	(ORCPT <rfc822;git-outgoing>); Fri, 4 May 2007 12:10:41 -0400
Received: from nz-out-0506.google.com ([64.233.162.239]:30955 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031060AbXEDQKj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2007 12:10:39 -0400
Received: by nz-out-0506.google.com with SMTP id o1so908224nzf
        for <git@vger.kernel.org>; Fri, 04 May 2007 09:10:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nkOWKkLNm5rWn706+FXBB5CHIIGN3TCSh6B69gDPdN9ocuj3BwzydQBXp8oJ13IB7v20d+Qd/zDjaF6S3TrkEeuyFzNyYtARJfsisEWvYa3+UZsQ0GTJuEmzBkPsDjxkBFDsaK/Xj6wzUI8zVKDbtFXtAp9+3NLbXwa99j+7IQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iNL4qPByxI7b4vhM+Ktl0FMQJifTLQ4YxOoDpnnIiZ4uSy2Lue6XIYgKGHP4m84BYUN9U3Tl3TrWng24Zog1ba+GD+xLsXPko2rbLahVy5eheMAWUJ64T9aRroxlpn2BEmKbj65MdYh/nGhi7o+9oBfb2ACCuwmJ8pYwcfj+hrc=
Received: by 10.114.178.1 with SMTP id a1mr1155274waf.1178295038730;
        Fri, 04 May 2007 09:10:38 -0700 (PDT)
Received: by 10.115.58.7 with HTTP; Fri, 4 May 2007 09:10:38 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.99.0705040937250.24220@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46187>

On 5/4/07, Nicolas Pitre <nico@cam.org> wrote:
> On Thu, 3 May 2007, Junio C Hamano wrote:
>
> > "Dana How" <danahow@gmail.com> writes:
> >
> > > So for a 25% increase in blob size I get 33% less elapsed time
> > > in git-add, all by changing core.compression from -1 to 1.
> > > I'll definitely take that improvement.  [For the compressible files
> > > we typically have, using 0 is a bad idea:  the CPU "advantage"
> > > is swamped out by the time to write a much larger file.]
> >
> > The above number is about loose objects, right?
> >
> > > Since I don't care [to the same degree] about the responsiveness of
> > > packing,  I'd rather pack with -1 or better to keep packs small.
> >
> > I see.  You are saying that the fact that core.compression is
> > used also for packing makes the variable less useful.
>
> I think that would make sense to have separate configs for pack and
> loose object compression.  When not specified they should simply default
> to core.compression if it exists.  Otherwise I'd suggest that pack
> compression default level be Z_DEFAULT_COMPRESSION and loose object
> compression default level be Z_BEST_SPEED.  This would make interactive
> operations like git-add and git-commit even faster by default.

I agree with your Z_BEST_SPEED idea.  I did not include it in
the patch b/c I didn't want to change any behavior in the absence
of new config settings.

Are you actually arguing for *3* different compression-related config
variables?  How about:
(a) core.compression controls loose objects. defaults to Z_BEST_SPEED.
(b) pack.compression controls packing. defaults to Z_DEFAULT_COMPRESSION
if neither variable exists. defaults to core.compression if only that exists

The last sentence mimics current behavior and to me seems least
surprising.  Or pack.compression could be simpler: default to
Z_DEFAULT_COMPRESSION if pack.compression doesn't exist
(no interaction with core.compression).

Thanks,
-- 
Dana L. How  danahow@gmail.com  +1 650 804 5991 cell
