From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC] git-am: support any number of signatures
Date: Fri, 13 Jun 2014 11:00:36 +0300
Message-ID: <20140613080036.GA2117@redhat.com>
References: <1402589505-27632-1-git-send-email-mst@redhat.com>
 <xmqqioo654mg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 10:00:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvMPK-0005bz-10
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 10:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbaFMIAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 04:00:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:16625 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751439AbaFMIAK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 04:00:10 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s5D808Pq012204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2014 04:00:08 -0400
Received: from redhat.com (ovpn-116-16.ams2.redhat.com [10.36.116.16])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with SMTP id s5D806oY030541;
	Fri, 13 Jun 2014 04:00:07 -0400
Content-Disposition: inline
In-Reply-To: <xmqqioo654mg.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251531>

On Thu, Jun 12, 2014 at 12:07:03PM -0700, Junio C Hamano wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > I'm using different signature tags for git am depending on the patch,
> > project and other factors.
> >
> > Sometimes I add multiple tags as well, e.g. QEMU
> > wants both Reviewed-by and Signed-off-by tags.
> >
> > This patch makes it easy to do so:
> > 1.  new parameter am.signoff can be used any number
> > 	of times:
> >
> > [am]
> > 	signoff = "Reviewed-by: Michael S. Tsirkin <mst@redhat.com>"
> > 	signoff = "Signed-off-by: Michael S. Tsirkin <mst@redhat.com>"
> >
> > 	if set all signatures are picked up when git am -s is used.
> 
> How does this interact with the logic to avoid appending the same
> Signed-off-by: line as the last one the incoming message already
> has?

Not handled if you have multiple signatures.
That will have to be fixed.
Do we only care about the last line?

Signed-off-by: A
Signed-off-by: B

do we want to add

Signed-off-by: A

or would it be better to replace with
Signed-off-by: B
Signed-off-by: A

?

Current git am will add A twice, I wonder if this is
a feature or a bug.

> > 2.  Any number of alternative signatures
> >
> > [am "a"]
> > 	signoff = "Acked-by: Michael S. Tsirkin <mst@redhat.com>"
> >
> > 	if set the signature type can be specified by passing
> > 	a parameter to the -s flag:
> >
> > 	git am -sa
> >
> > No docs or tests, sorry, so not yet ready for master, but I'm using this
> > all the time without any issues so maybe ok for pu.
> > Early flames/feedback/help welcome.
> 
> How does that "a" in [am "a"] work?  If it defines some kind of
> scope (i.e. use am.a.* instead of am.* when I specify I am using "a"
> set somehow), that might be something interesting, but if it applies
> only to sign-off and other things, then I am not sure if I like it,
> as that would invite confusions from end users.
> 
> > +		signoffs=("${signoffs[@]}" "${s[@]}") ;;
> 
> Is this a shell array?  It won't fly in our codebase if that is the
> case.
