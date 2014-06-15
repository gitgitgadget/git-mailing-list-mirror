From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Sun, 15 Jun 2014 13:27:36 +0300
Message-ID: <20140615102736.GA11798@redhat.com>
References: <1402589505-27632-1-git-send-email-mst@redhat.com>
 <xmqqioo654mg.fsf@gitster.dls.corp.google.com>
 <20140613080036.GA2117@redhat.com>
 <xmqqy4x03ecm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 12:30:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ww7hY-0003Hm-P9
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 12:30:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbaFOK1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 06:27:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50438 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750999AbaFOK1L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 06:27:11 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5FAR88U012599
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 15 Jun 2014 06:27:08 -0400
Received: from redhat.com (ovpn-116-16.ams2.redhat.com [10.36.116.16])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s5FAR6d9012567;
	Sun, 15 Jun 2014 06:27:07 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy4x03ecm.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251674>

On Fri, Jun 13, 2014 at 10:32:09AM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > On Thu, Jun 12, 2014 at 12:07:03PM -0700, Junio C Hamano wrote:
> >> "Michael S. Tsirkin" <mst@redhat.com> writes:
> >> ...
> >> > 1.  new parameter am.signoff can be used any number
> >> > 	of times:
> >> >
> >> > [am]
> >> > 	signoff = "Reviewed-by: Michael S. Tsirkin <mst@redhat.com>"
> >> > 	signoff = "Signed-off-by: Michael S. Tsirkin <mst@redhat.com>"
> >> >
> >> > 	if set all signatures are picked up when git am -s is used.
> >> 
> >> How does this interact with the logic to avoid appending the same
> >> Signed-off-by: line as the last one the incoming message already
> >> has?
> >
> > Not handled if you have multiple signatures.
> > That will have to be fixed.
> > Do we only care about the last line?
> >
> > Signed-off-by: A
> > Signed-off-by: B
> >
> > do we want to add
> >
> > Signed-off-by: A
> >
> > or would it be better to replace with
> > Signed-off-by: B
> > Signed-off-by: A
> >
> > ?
> >
> > Current git am will add A twice, I wonder if this is
> > a feature or a bug.
> 
> This is very much deliberate.
> 
> Appending A after existing A and B is meant to record that the patch
> originated from A, passed thru B possibly with changes by B, came
> back to A who wants to assert that the result is still under DCO.
> 
> The only case we can safely omit appending A's sign-off is when the
> last one in the chain is by A.  Imagine that you had a patch signed
> off by B, which A may have tweaked and forwarded under DCO with A's
> sign-off.  Such a patch would have sign-off chain B-A.
> 
> Now A makes further changes to the patch and says "the further
> change is also something I am authorized to release as open source"
> with the "-s" option or some other way.  It would not change that A
> can contribute under DCO if we did not add an extra A after existing
> B-A sign-off chain in that case.

OK imagine we have signatures:
A
B

Now A wants to sign this patch.

I think there are two reasonable ways to behave:
1. What you describe above:
A
B
A

2. For things like Tested-by: tags, removing tag from
where it was and adding it at the bottom:

B
A


This probably calls for a separate feature:
maybe adding "acks" along with "signoffs"?
acks would be unique, re-adding ack removes it from
the message and adds at the bottom.

-- 
MST
