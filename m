From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/9] Introduce publish tracking branch
Date: Fri, 11 Apr 2014 09:25:04 -0500
Message-ID: <20140411142504.GA25376@nysa.casa.local>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
 <vpqtxa0jkfo.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>,
	John Szakmeister <john@szakmeister.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 11 16:35:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYcY3-0000Dc-04
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 16:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758948AbaDKOfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 10:35:07 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:39872 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755863AbaDKOfF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 10:35:05 -0400
Received: by mail-ob0-f177.google.com with SMTP id wo20so5854422obc.8
        for <git@vger.kernel.org>; Fri, 11 Apr 2014 07:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ifjsj4K3ZZmFxNd0Izg58a6hq0d7K46cZgQnG+hJ5SA=;
        b=VUH0InT6hR8rs9Hz/TKz8EU/doLq3eOwkXikD25JfeSKizHmOO7B/yz+A650OJbgZp
         005PQVSRmlx5GbtsrsQhJC/zc4M6WNWzJcW3VKxp9AmiGfCMJl2fInHUdIqPpCdXaMgJ
         Hm1RynUsarIovMrvv0tk6VygDRPS5M/Wq2FmjqBkA5VnLF/S8DMct4y5ayOg5noy2blV
         bnNcDKSisRHxhReWxbSdIsbf/dNqwW4NwBDnWiF3YeL2Cy1fHNwOW4e/LV8Wp/uyuAjk
         qSoh7V2E1pxUAMu92ddWQtIurv5/L3v8g55pcnaDy4WYYWqGdR2+0WonwcES8zjon1UU
         cpeA==
X-Received: by 10.182.29.33 with SMTP id g1mr7789925obh.53.1397226904616;
        Fri, 11 Apr 2014 07:35:04 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id nr7sm12564899obc.22.2014.04.11.07.35.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Apr 2014 07:35:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpqtxa0jkfo.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246096>

Matthieu Moy wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > As it has been discussed before, our support for triangular workflows is
> > lacking, and the following patch series aims to improve that situation.
> 
> I'm not a heavy user of triangular workflow, so I'm not in the best
> position to comment (and I have no time for a real review, sorry).
> 
> On overall, I do like the change. I played a bit with it, and do not
> understand what "git push" does:
> 
>   $ git status
>   On branch master
>   Your branch is ahead of 'origin/new' by 4 commits.
>     (use "git push" to publish your local commits)
> 
> => OK, it's using the publish branch to tell me whether I should push.
> 
>   $ git push -v
>   Pushing to /tmp/git
>   To /tmp/git
>    = [up to date]      master -> master
>   updating local tracking ref 'refs/remotes/origin/master'
>   Everything up-to-date
> 
> => Err, it still pushes to the upstream branch ... Wasn't that the point
> of the change to push to publish? Did I do something wrong?

My patch series only affects push.default=simple, perhaps you have a
different configuration.

Maybe we want the publish branch to override any push.default, so:

--- a/builtin/push.c
+++ b/builtin/push.c
@@ -195,11 +195,7 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
 static void setup_push_simple(struct remote *remote, struct branch *branch,
                int triangular)
 {
-       if (branch->push_name) {
-               struct strbuf refspec = STRBUF_INIT;
-               strbuf_addf(&refspec, "%s:%s", branch->name, branch->push_name);
-               add_refspec(refspec.buf);
-       } else if (triangular) {
+       if (triangular) {
                setup_push_current(remote, branch);
        } else {
                setup_push_upstream(remote, branch, triangular);
@@ -260,8 +256,16 @@ static struct branch *get_current_branch(struct remote *remote)
 
 static void setup_default_push_refspecs(struct remote *remote)
 {
+       struct branch *branch = branch_get(NULL);
        int triangular = is_workflow_triangular(remote);
 
+       if (branch && branch->push_name) {
+               struct strbuf refspec = STRBUF_INIT;
+               strbuf_addf(&refspec, "%s:%s", branch->name, branch->push_name);
+               add_refspec(refspec.buf);
+               return;
+       }
+
        switch (push_default) {
        default:
        case PUSH_DEFAULT_UNSPECIFIED:

-- 
Felipe Contreras
