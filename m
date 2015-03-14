From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 1/4] git-credential-store: support multiple credential
 files
Date: Sat, 14 Mar 2015 13:33:29 -0400
Message-ID: <20150314173328.GA32599@peff.net>
References: <1426056553-9364-1-git-send-email-pyokagan@gmail.com>
 <1426056553-9364-2-git-send-email-pyokagan@gmail.com>
 <20150313061530.GA24588@peff.net>
 <CACRoPnR9pTc2LC87Vf0bMAgTj-FnbsRBpjn+3RCxCP6yrzsCkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 18:33:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWpwP-000466-RC
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 18:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbbCNRdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 13:33:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:33071 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751153AbbCNRdc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 13:33:32 -0400
Received: (qmail 26748 invoked by uid 102); 14 Mar 2015 17:33:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 14 Mar 2015 12:33:32 -0500
Received: (qmail 2569 invoked by uid 107); 14 Mar 2015 17:33:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 14 Mar 2015 13:33:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Mar 2015 13:33:29 -0400
Content-Disposition: inline
In-Reply-To: <CACRoPnR9pTc2LC87Vf0bMAgTj-FnbsRBpjn+3RCxCP6yrzsCkw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265452>

On Sat, Mar 14, 2015 at 04:15:53PM +0800, Paul Tan wrote:

> Even though in this case the store_credential() function is not used
> anywhere else, from my personal API design experience I think that
> cementing the rule of "the first file in the list is the default" in
> the behavior of the function is not a good thing. For example, in the
> future, we may wish to keep the precedence ordering the same, but if
> none of the credential files exist, we create the XDG file by default
> instead. It's a balance of flexibility, but in this case I think
> putting the default filename in a separate argument is a good thing.

Yeah, I see your line of reasoning. I think this is probably a case of
YAGNI, but it is really a matter of personal preference. It's not a big
deal either way.

> > So you can just call the regular string_list_append here (the idea of
> > declaring the list as DUP or NODUP is that the callers do not have to
> > care; string_list_append does the right thing).
> 
> Actually, thinking about it again from a memory management
> perspective, STRING_LIST_INIT_DUP should be used instead as the
> string_list `fns` should own the memory of the strings inside it.
> Thus, in this case since `file` is pulled from the argv array,
> string_list_append() should be used to duplicate the memory, and for
> expand_user_path(), string_list_append_nodup() should be used because
> the returned path is newly-allocated memory. Finally,
> string_list_clear() should be called at the end to release memory.

Yeah, I had the same thought, but I noticed that you don't call
string_list_clear. Nor is it really necessary to do so. Since git
programs are generally short-lived, we often let the OS take care of
deallocating variables like this (it's not appropriate for all
variables, of course, but quite frequently there are variables that are
effectively allocated at program startup and used until program end).

Again, I think this is a matter of taste. I don't mind if you want to
string_list_clear at the end, and I agree that using nodup() is the
right thing in that case.

-Peff
