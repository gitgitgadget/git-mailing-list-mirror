From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Sun, 27 May 2007 22:30:17 -0400
Message-ID: <465A3EB9.7090403@gmail.com>
References: <20070526052419.GA11957@spearce.org>	 <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net>	 <56b7f5510705261031o311b89bapd730374cbc063931@mail.gmail.com>	 <20070527033429.GY28023@spearce.org>	 <56b7f5510705262140rea5e1e5r49bdd5e99c466daa@mail.gmail.com>	 <alpine.LFD.0.99.0705271127110.3366@xanadu.home>	 <20070527213525.GC28023@spearce.org> <56b7f5510705271835m5a375324p3a908fe766fdf902@mail.gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 28 04:30:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsV09-0000Jp-At
	for gcvg-git@gmane.org; Mon, 28 May 2007 04:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbXE1CaV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 22:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752123AbXE1CaV
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 22:30:21 -0400
Received: from wx-out-0506.google.com ([66.249.82.232]:51604 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325AbXE1CaU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 22:30:20 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1124142wxc
        for <git@vger.kernel.org>; Sun, 27 May 2007 19:30:19 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=mvDFle6RK+brKAmBfKbJGhbLD3rqOhHlgplbiFdRYtebqgpnjCiEoaQi4c/hnvAWXNC6HOeNZW6SShE7bNPnNiV3Rzti144D0Ab1pbMO3KQbQ/r+SKVpqgVBUCqY3MM+TzOi8zZexilXkJ4hoxf9UxzCanyXdGyS6206oWJm/qU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=cTbYAOrJWvQFVahuRCqDt/Dw8LsByMig8hCiqGN1lSEy+UaY24Q67nAkc+HoiPKayKB0DAodDSDzm9XfdBxkdpj2zcrX0KVP1bCWRddGpUPo5PAZKV8A+nfFOtCX8pWwKXtltydPt7KlZn/VVigxzH//+GZ+Quq9mvpP+hJeXYo=
Received: by 10.70.65.5 with SMTP id n5mr7658809wxa.1180319419853;
        Sun, 27 May 2007 19:30:19 -0700 (PDT)
Received: from ?10.0.0.6? ( [66.177.19.99])
        by mx.google.com with ESMTP id h38sm11705537wxd.2007.05.27.19.30.18;
        Sun, 27 May 2007 19:30:19 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <56b7f5510705271835m5a375324p3a908fe766fdf902@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48608>

Dana How wrote:
[...]
> 
> Some history of what I've been doing with git:
> First I simply had to import the repo,
> which led to split packs (this was before index v2).
> Then maintaining the repo led to the unfinished maxblobsize stuff.
> Distributing the repo included users pulling (usually) from the central 
> repo,
> which would be trivial since it was also an alternate.
> Local repacking would avoid heavy load on it.
> 
> Now I've started looking into how to push back into the
> central repo from a user's repo (not everything will be central;
> some pulling between users will occur
> otherwise I wouldn't be as interested).
> 
> It looks like the entire sequence is:
> A. git add file [compute SHA-1 & compress file into objects/xx]
> B. git commit [write some small objects locally]
> C. git push {using PROTO_LOCAL}:
> 1. read & uncompress objects
> 2. recompress objects into a pack and send through a pipe
> 3. read pack on other end of pipe and uncompress each object
> 4. compute SHA-1 for each object and compress file into objects/xx
> 
> So, after creating an object in the local working tree,
> to get it into the central repo,  we must:
> compress -> uncompress -> compress -> uncompress -> compress.
> In responsiveness this won't compare very well to Perforce,
> which has only one compress step.
> 
> The sequence above could be somewhat different currently in git.
> The user might have repacked their repo before pushing,
> but this just moves C1 and C2 back earlier in time,
> it doesn't remove the need for them.  Besides,  the blobs in
> a push are more likely to be recent and hence unpacked.
> 
> Also,  C3 and C4 might not happen if more than 100 blobs get pushed.
> But this seems very unusual; only 0.3% of commits in the history
> had 100+ new files/file contents.  If the 100 level is reduced,
> then the central repo fills up with packfiles and their index files,
> reducing performance for everybody (using the central repo as an 
> alternate).
> 
> Thus there really is 5X more compression activity going on
> compared to Perforce.  How can this be reduced?
> 
> One way is to restore the ability to write the "new" loose object format.
> Then C1, C2, and C4 disappear.  C3 must remain because we need
> to uncompress the object to compute its SHA-1;  we don't need
> to recompress since we were already given the compressed form.
> 
> And that final sentence is why I sent this email:  if the packfile
> contained the SHA-1s,  either at the beginning or before each object,
> then they wouldn't need to be recomputed at the receiving end
> and the extra decompression could be skipped as well.  This would
> make the total zlib effort the same as Perforce.
> 
> The fact that a loose object is never overwritten would still be retained.
> Is that sufficient security?  Or does the SHA-1 always need to be
> recomputed on the receiving end?  Could that be skipped just for
> specific connections and/or protocols (presumably "trusted" ones)?
[...]

So how do you want to decide when to trust the sender and when to 
validate that the objects received have the SHA-1's claimed? A _central_ 
repository, being authoritative, would need to _always_ validate _all_ 
objects it receives. An since, with a central repository setup, the 
central repository is where the CPU resources are the most in demand, 
validating the object IDs when received at the developers repositories 
should not be a problem. And just to be fair, how does Perforce 
guarantee that the retrieved version of a file matches what was checked in?
