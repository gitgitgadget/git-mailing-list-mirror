From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 4/6] patch-id: make it stable against hunk reordering
Date: Thu, 24 Apr 2014 09:29:38 +0300
Message-ID: <20140424062938.GA30231@redhat.com>
References: <1398255277-26303-1-git-send-email-mst@redhat.com>
 <1398255277-26303-4-git-send-email-mst@redhat.com>
 <xmqq4n1k0wtw.fsf@gitster.dls.corp.google.com>
 <20140423175717.GB28308@redhat.com>
 <xmqqzjjbwvk9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 08:29:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdD9Z-0003ot-B7
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 08:29:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbaDXG24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 02:28:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:10369 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751503AbaDXG2z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 02:28:55 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s3O6SsPO032568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 24 Apr 2014 02:28:54 -0400
Received: from redhat.com (ovpn-116-36.ams2.redhat.com [10.36.116.36])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with SMTP id s3O6SqoO001209;
	Thu, 24 Apr 2014 02:28:53 -0400
Content-Disposition: inline
In-Reply-To: <xmqqzjjbwvk9.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246942>

On Wed, Apr 23, 2014 at 03:05:42PM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Wed, Apr 23, 2014 at 10:39:23AM -0700, Junio C Hamano wrote:
> >> Are these three patches the same as what has been queued on
> >> mt/patch-id-stable topic and cooking in 'next' for a few weeks?
> >
> > Not exactly - at your request I implemented git config
> > options to control patch id behaviour.
> > Documentation and tests updated to match.
> 
> After comparing the patches 4-6 and the one that has been in 'next'
> for a few weeks, I tried to like the new one, but I couldn't.

I'm fine with the one in next too.
I was under the impression that you wanted me to change
the behaviour so I worked on this, but previous version was sufficient
for my purposes (which is really all about putting diff.orderfile
upstream).

> The new one, if I am reading the patch correctly, makes the stable
> variant the default if
> 
>  - the configuration explicitly asks to use it; or
> 
>  - diff.orderfile, which is a new configuration that did not exist,
>    is used.
> 
> At the first glance, the latter makes it look as if that will not
> hurt any existing users/repositories, but the thing is, the producer
> of the patches is different from the consumer of the patches.  There
> needs to be a way for a consumer to say "I need stable variant" on
> the patches when computing "patch-id" on a patch that arrived.  As
> long as two different producers use two different orders, the
> consumer of the patches from these two sources is forced to use the
> stable variant if some sort of cache is kept keyed with the
> patch-ids.
> 
> But "diff.orderfile" configuration is all and only about the
> producer, and does not help the case at all.

OK, we can just drop that, that's easy.

> Compared to it, the previous version forced people who do not have a
> particular reason to choose between the variants to use the new
> "stable" variant, which was a lot simpler solution.
> 
> The reason why I merged the previous one to 'next' was because I
> wanted to see if the behaviour change is as grave as I thought, or I
> was just being unnecessary cautious.  If there is no third-party
> script that precomputes something and stores them under these hashes
> that breaks with this change, I do not see any reason not to make
> the new "stable" one the default.

Ah okay, so we just wait a bit and see and if all is quiet the
existing patch will graduate to master with time?
Totally cool.
I thought you wanted me to add the config option, but if everyone
is happy as is, I don't need it personally at all.

> I however suspect that the ideal "stable" implementation may be
> different from what you implemented.  What if we compute a patch-id
> on a reordered patch as if the files came in the "usual" order?

ATM patch id does not have any concept of the usual order,
so that's one problem - how does one figure out what the order would be?
I have no idea - is this documented anywhere?
Also I'm guessing this would depend on the state of the git tree which
would be another behaviour change: previously patch-id worked
fine outside any git tree.

>
> That would be another way to achieve the stable-ness for sane cases
> (i.e. no funny "you could split one patch with two hunks into two
> patches with one hunk each twice mentioning the same path" which is
> totally an uninteresting use case---diff.orderfile would not even
> produce such a patch)

Yes I'm thinking we should drop this hunk in the patch:
let's support reordering files but not splitting them.
This makes the change even smaller, so I now think we should
just go for it.

> and a huge difference would be that it would
> produce the same patch-id as existing versions of Git, if the patch
> is not reordered.  Is that asking for a moon (I admit that I haven't
> looked at the code involved too deeply)?

Yes this would be a bunch of code to write - certainly much more complex than
the existing small patch which just tweaks the checksum slightly to make
it stable.

-- 
MST
