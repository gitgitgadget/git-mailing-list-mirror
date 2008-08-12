From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] pack-objects: Allow missing base objects when creating
	thin packs
Date: Tue, 12 Aug 2008 11:18:43 -0700
Message-ID: <20080812181843.GD31092@spearce.org>
References: <20080811182839.GJ26363@spearce.org> <7vk5enuqfg.fsf@gitster.siamese.dyndns.org> <20080811224404.GQ26363@spearce.org> <20080812012859.GT26363@spearce.org> <alpine.LFD.1.10.0808120023250.22892@xanadu.home> <20080812164149.GB31092@spearce.org> <alpine.LFD.1.10.0808121402440.22892@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Aug 12 20:19:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSyTD-0006bJ-JO
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 20:19:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbYHLSSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 14:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbYHLSSo
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 14:18:44 -0400
Received: from george.spearce.org ([209.20.77.23]:43729 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbYHLSSo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 14:18:44 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8A83138375; Tue, 12 Aug 2008 18:18:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0808121402440.22892@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92125>

Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 12 Aug 2008, Shawn O. Pearce wrote:
> > +# Clone patch_clone indirectly by cloning base and fetching.
> > +#
> > +test_expect_success \
> > +    'indirectly clone patch_clone' \
> > +    '(mkdir user_clone &&
> > +      cd user_clone &&
> > +      git init &&
> > +      git pull ../.git &&
> > +      test $(git rev-parse HEAD) = $B
> > +
> > +      git pull ../patch_clone/.git &&
> > +      test $(git rev-parse HEAD) = $C
> > +     )
> > +    '
> 
> What if the first test command fails?  Won't its result be ignored?

Isn't the exit status of the subshell the exit status of the last
command in the subshell?

I just changed the test line to compare to "x$C" instead of $C
and it correctly detected the error condition:

$ git diff
diff --git a/t/t5306-pack-nobase.sh b/t/t5306-pack-nobase.sh
index 503e9d4..7c55e9e 100755
--- a/t/t5306-pack-nobase.sh
+++ b/t/t5306-pack-nobase.sh
@@ -62,7 +62,7 @@ test_expect_success \
       test $(git rev-parse HEAD) = $B

       git pull ../patch_clone/.git &&
-      test $(git rev-parse HEAD) = $C
+      test $(git rev-parse HEAD) = x$C
      )
     '

$ ./t5306-pack-nobase.sh
*   ok 1: setup base
*   ok 2: setup patch_clone
* FAIL 3: indirectly clone patch_clone
        (mkdir user_clone &&
              cd user_clone &&
              git init &&
              git pull ../.git &&
              test $(git rev-parse HEAD) = $B

              git pull ../patch_clone/.git &&
              test $(git rev-parse HEAD) = x$C
             )

*   ok 4: clone of patch_clone is incomplete
* failed 1 among 4 test(s)

-- 
Shawn.
