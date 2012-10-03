From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: upload-pack is slow with lots of refs
Date: Wed, 3 Oct 2012 22:16:56 +0200
Message-ID: <CACBZZX4Grya=FbL9XEh_EK6KVsFZYWCuHveV2QevcBwr+iYTMQ@mail.gmail.com>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
 <20121003180324.GB27446@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:53:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtJB-0001DP-8b
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565Ab2JCURT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2012 16:17:19 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49291 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab2JCURS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Oct 2012 16:17:18 -0400
Received: by obbuo13 with SMTP id uo13so7746260obb.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 13:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=dmgh2zfc/IC8iFJSLSr3NLFQuPBgA6MRYM5K7LexYvA=;
        b=gQocrH5RNCSBVfzuKgd1THinhkMC1WbJK3LE5GJQL+Mg+Tvc5iQ1xZ8IId7Aw+t03g
         h+vCBuKS8xLZ62/2tXfjGnUENjYD1kFmWA9wMAHL+ZuktnvFXBThE7sCensryWl/Brgd
         +SbBV/VPa7dV6hD02SCtzvsx7cc6ytmf/bQ0fVAoq2Qo4aYrgwEUAWHTyx8qXeD4BU5q
         wS+jT+wGA0fw5eHWvyO/teULp+obOuHPIb6SQy8V5SLcfjzDfZ+VLgCTwZjYB+PcoPsV
         vCr0sZCN9aaM8fIk+AMTeD8uOOFUFKbko93hHDoO6RFzSU7wEVwxOxbcq9nBNmEe1Mw0
         MqeA==
Received: by 10.182.207.6 with SMTP id ls6mr2532433obc.36.1349295437321; Wed,
 03 Oct 2012 13:17:17 -0700 (PDT)
Received: by 10.60.94.225 with HTTP; Wed, 3 Oct 2012 13:16:56 -0700 (PDT)
In-Reply-To: <20121003180324.GB27446@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206938>

On Wed, Oct 3, 2012 at 8:03 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Oct 03, 2012 at 02:36:00PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>
>> I'm creating a system where a lot of remotes constantly fetch from a
>> central repository for deployment purposes, but I've noticed that ev=
en
>> with a remote.$name.fetch configuration to only get certain refs a
>> "git fetch" will still call git-upload pack which will provide a lis=
t
>> of all references.
>>
>> This is being done against a repository with tens of thousands of re=
fs
>> (it has a tag for each deployment), so it ends up burning a lot of C=
PU
>> time on the uploader/receiver side.
>
> Where is the CPU being burned? Are your refs packed (that's a huge
> savings)? What are the refs like? Are they .have refs from an alterna=
tes
> repository, or real refs? Are they pointing to commits or tag objects=
?
>
> What version of git are you using?  In the past year or so, I've made
> several tweaks to speed up large numbers of refs, including:
>
>   - cff38a5 (receive-pack: eliminate duplicate .have refs, v1.7.6); n=
ote
>     that this only helps if they are being pulled in by an alternates
>     repo. And even then, it only helps if they are mostly duplicates;
>     distinct ones are still O(n^2).
>
>   - 7db8d53 (fetch-pack: avoid quadratic behavior in remove_duplicate=
s)
>     a0de288 (fetch-pack: avoid quadratic loop in filter_refs)
>     Both in v1.7.11. I think there is still a potential quadratic loo=
p
>     in mark_complete()
>
>   - 90108a2 (upload-pack: avoid parsing tag destinations)
>     926f1dd (upload-pack: avoid parsing objects during ref advertisem=
ent)
>     Both in v1.7.10. Note that tag objects are more expensive to
>     advertise than commits, because we have to load and peel them.
>
> Even with those patches, though, I found that it was something like ~=
2s
> to advertise 100,000 refs.

I can't provide all the details now (not with access to that machine
now), but briefly:

 * The git client/server version is 1.7.8

 * The repository has around 50k refs, they're "real" refs, almost all
   of them (say all but 0.5k-1k) are annotated tags, the rest are
   branches.

 * >99% of them are packed, there's a weekly cronjob that packs them
   all up, there were a few newly pushed branches and tags outside of
   the

 * I tried "echo -n | git upload-pack <repo>" on both that 50k
   repository and a repository with <100 refs, the former took around
   ~1-2s to run on a 24 core box and the latter ~500ms.

 * When I ran git-upload-pack with GNU parallel I managed around 20/s
   packs on the 24 core box on the 50k ref one, 40/s on the 100 ref
   one.

 * A co-worker who was working on this today tried it on 1.7.12 and
   claimed that it had the same performance characteristics.

 * I tried to profile it under gcc -pg && echo -n | ./git-upload-pack
   <repo> but it doesn't produce a profile like that, presumably
   because the process exits unsuccessfully.

   Maybe someone here knows offhand what mock data I could feed
   git-upload-pack to make it happy to just list the refs, or better
   yet do a bit more work which it would do if it were actually doing
   the fetch (I suppose I could just do a fetch, but I wanted to do
   this from a locally compiled checkout).

>> Has there been any work on extending the protocol so that the client
>> tells the server what refs it's interested in?
>
> I don't think so. It would be hard to do in a backwards-compatible wa=
y,
> because the advertisement is the first thing the server says, before =
it
> has negotiated any capabilities with the client at all.

I suppose at least for the ssh protocol we could just do:

    ssh server "(git upload-pack <repo> --refs=3D* || git upload-pack <=
repo>)"

And something similar with HTTP headers, but that of course leaves the
git:// protocol.
