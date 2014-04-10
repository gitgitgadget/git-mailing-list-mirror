From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 9/9] sha1_name: add support for @{publish} marks
Date: Thu, 10 Apr 2014 17:25:25 -0500
Message-ID: <53471a55767f1_d696b12f01c@nysa.notmuch>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
 <1397156686-31349-10-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0nC7Ai_LbJNpy-oK-qfWZELx6NVWTNS-5iWzhn8t9JoTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>, Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 00:36:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYNZe-0005Gl-IU
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 00:35:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878AbaDJWf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Apr 2014 18:35:26 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:53509 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865AbaDJWfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Apr 2014 18:35:25 -0400
Received: by mail-oa0-f53.google.com with SMTP id j17so5135266oag.26
        for <git@vger.kernel.org>; Thu, 10 Apr 2014 15:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=8AuodG/uh9POUipyYv1yZOW8UjphJzF2SIPVoLvKfDU=;
        b=IxEVnbqlwSRShcp9Bb0nY+oiifudZx7zhs8BTnI2Kw97KLM7cLisZAo4DMrtcnA5ci
         sZR2e39u+A8btQEjs+3CYMTtZ/MMagP7sf0f0juNF2Lf6cIDjRGxIc3AlhYVo1Y0J1oF
         Ep3ksBKfT/Oce2zlZqTAQafpzog/+f0rQvoyr2Y+uu2MKyVX/pHyyYGth1GmxfZAOc0K
         C+khuXCNq/hNQUVJjX+gcEwdH3ZJ6Lvkq7YJ/Fwfez/c/yTOgMdd502P/4eAJU7QgXjm
         tIkt8Cq2g4vzQVopkauD8nsEnTXRAcrrhKARDuoMUrl8HgsQ00s9YBUnqdD/+Yj01S8S
         EyqA==
X-Received: by 10.60.155.72 with SMTP id vu8mr3990670oeb.60.1397169325429;
        Thu, 10 Apr 2014 15:35:25 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id te6sm23276130oec.2.2014.04.10.15.35.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Apr 2014 15:35:24 -0700 (PDT)
In-Reply-To: <CALkWK0nC7Ai_LbJNpy-oK-qfWZELx6NVWTNS-5iWzhn8t9JoTw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246060>

Ramkumar Ramachandra wrote:
> Felipe Contreras wrote:
> > @@ -1068,23 +1069,35 @@ static const char *get_upstream_branch(const char *name_buf, int len)
> >          */
> >         if (!branch)
> >                 die(_("HEAD does not point to a branch"));
> > -       if (!branch->merge || !branch->merge[0]->dst) {
> > -               if (!ref_exists(branch->refname))
> > -                       die(_("No such branch: '%s'"), name);
> > -               if (!branch->merge) {
> > -                       die(_("No upstream configured for branch '%s'"),
> > -                               branch->name);
> > +       switch (type) {
> > +       case 'u':
> > +               if (!branch->merge || !branch->merge[0]->dst) {
> > +                       if (!ref_exists(branch->refname))
> > +                               die(_("No such branch: '%s'"), name);
> > +                       if (!branch->merge) {
> > +                               die(_("No upstream configured for branch '%s'"),
> > +                                       branch->name);
> > +                       }
> > +                       die(
> > +                               _("Upstream branch '%s' not stored as a remote-tracking branch"),
> > +                               branch->merge[0]->src);
> > +               }
> > +               tracking = branch->merge[0]->dst;
> > +               break;
> > +       case 'p':
> > +               if (!branch->push.dst) {
> > +                       die(_("No publish configured for branch '%s'"),
> > +                                       branch->name);
> 
> This assumes a push.default value of 'current' or 'matching'. What
> happens if push.default is set to 'nothing' or 'upstream', for
> instance?

Why would that matter? @{upstream} doesn't depend on this, neither does
@{publish}; @{upstream} is .remote+.merge, @{publish} is .pushremote+.push.

If the user hasn't configured a publish branch, @{publish} fails.

-- 
Felipe Contreras
