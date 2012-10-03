From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: upload-pack is slow with lots of refs
Date: Thu, 4 Oct 2012 00:32:35 +0200
Message-ID: <CACBZZX4Fb0OCkh5kwKvLC+_0xb7q-UB7LH2_WY=dFN5SYUeezQ@mail.gmail.com>
References: <CACBZZX70NTic2WtrXooTg+yBbiFFDAEX_Y-b=W=rAkcYKJ3T2g@mail.gmail.com>
 <20121003180324.GB27446@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:06:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtLB-0001DP-1x
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:52:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756680Ab2JCWc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 18:32:57 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53087 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475Ab2JCWc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 18:32:56 -0400
Received: by obbuo13 with SMTP id uo13so7875030obb.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 15:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LycUkFuxUK0PFU8Q53EJeVBJRF0hpi1JAi7vhad4Clo=;
        b=Oajki0i9Q1WKYzF7fc2i6IpVLQPQCI92qJCt3KcztYk4YlTJiHP1yzsM1wKz87cMjB
         e5zu7hhDDkmfM72oGzsWmViUB7mJjuHMiv5rs0LUE2q+827IUfhcQsUUJnc4xGEhkY4f
         Ey8DLVvvAK+xsY1HkVXvljzbHvqZmxRK5X+rVUflVd4OMTawOVZUJtVx84xznJa9ZSY7
         g9QAmESuVvk1KSH1ruz3wkTs9cUjcEFOZzYAJA0fDQbMuwRhJd4JOWKO9ydT317zf+dU
         DMMjwfg9+9BQqYSvOLkHh4wfEgfV6jbysZR/59eBM+tI/gE13vy/R5dzwtNT9NAPKcyY
         7lgg==
Received: by 10.60.24.69 with SMTP id s5mr2837084oef.45.1349303575503; Wed, 03
 Oct 2012 15:32:55 -0700 (PDT)
Received: by 10.60.94.225 with HTTP; Wed, 3 Oct 2012 15:32:35 -0700 (PDT)
In-Reply-To: <20121003180324.GB27446@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206964>

On Wed, Oct 3, 2012 at 8:03 PM, Jeff King <peff@peff.net> wrote:
> What version of git are you using?  In the past year or so, I've made
> several tweaks to speed up large numbers of refs, including:
>
>   - cff38a5 (receive-pack: eliminate duplicate .have refs, v1.7.6); note
>     that this only helps if they are being pulled in by an alternates
>     repo. And even then, it only helps if they are mostly duplicates;
>     distinct ones are still O(n^2).
>
>   - 7db8d53 (fetch-pack: avoid quadratic behavior in remove_duplicates)
>     a0de288 (fetch-pack: avoid quadratic loop in filter_refs)
>     Both in v1.7.11. I think there is still a potential quadratic loop
>     in mark_complete()
>
>   - 90108a2 (upload-pack: avoid parsing tag destinations)
>     926f1dd (upload-pack: avoid parsing objects during ref advertisement)
>     Both in v1.7.10. Note that tag objects are more expensive to
>     advertise than commits, because we have to load and peel them.
>
> Even with those patches, though, I found that it was something like ~2s
> to advertise 100,000 refs.

FWIW I bisected between 1.7.9 and 1.7.10 and found that the point at
which it went from 1.5/s to 2.5/s upload-pack runs on the pathological
git.git repository was none of those, but:

    ccdc6037fe - parse_object: try internal cache before reading object db
