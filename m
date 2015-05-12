From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 3/3] cat-file: add --follow-symlinks to --batch
Date: Tue, 12 May 2015 17:53:29 -0400
Organization: Twitter
Message-ID: <1431467609.16652.35.camel@ubuntu>
References: <1431384645-17276-1-git-send-email-dturner@twopensource.com>
	 <1431384645-17276-4-git-send-email-dturner@twopensource.com>
	 <xmqqoalpzn3s.fsf@gitster.dls.corp.google.com>
	 <1431455779.16652.20.camel@ubuntu>
	 <xmqqh9rhftlh.fsf@gitster.dls.corp.google.com>
	 <1431466646.16652.32.camel@ubuntu>
	 <xmqqiobxealk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 12 23:53:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsI7S-0002e3-03
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 23:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934095AbbELVxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 17:53:36 -0400
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34731 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904AbbELVxd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 17:53:33 -0400
Received: by qkgx75 with SMTP id x75so16035196qkg.1
        for <git@vger.kernel.org>; Tue, 12 May 2015 14:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=/iEd5Nq0ax9E1jXB0pNvz9T4D3TKatorSc/ftE64cmo=;
        b=QksozVuspNoAH1bbjPxqbXm3Ub1SBx+BwZ3JvTB1/F8zW1Ffo0VEqf/8slAIQnAhfi
         HtutWWsZDt23X5fj8rF1WlSw4nYNzw/6pMVg2FhxUDnZsJyecwYO93vBHAZCYsyHS2J5
         xXi7UWkmkKENTxQoPZyeaiGpPjEYIcSlbVZMsagliOkLMZscTuktCA9a/+BQIdxIDU7E
         qbbampwzDt9jEBZr8F5OWelyhUt+RMq1Lfn2ByjRB9mut7aumZrq4Se8HSJfR8bZJOJN
         Q+o/XLMHuIpBUrUOoDIiyVvPF4ClRRl+1r1ucZuRSzbzpsfouzeS8xJMevHOee0bP+Jq
         nJDQ==
X-Gm-Message-State: ALoCoQlr/deEHmiC872itZIfwQTWWOp4luhcSbgqKslEN8R6tQ88RGGBLxTFOP4a+X1bR31gh6OO
X-Received: by 10.55.17.21 with SMTP id b21mr36579335qkh.71.1431467611907;
        Tue, 12 May 2015 14:53:31 -0700 (PDT)
Received: from [172.22.38.222] ([192.133.79.147])
        by mx.google.com with ESMTPSA id 69sm14167318qhv.17.2015.05.12.14.53.30
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2015 14:53:30 -0700 (PDT)
In-Reply-To: <xmqqiobxealk.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268898>

On Tue, 2015-05-12 at 14:42 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > On Tue, 2015-05-12 at 13:07 -0700, Junio C Hamano wrote:
> >> David Turner <dturner@twopensource.com> writes:
> >> 
> >> >>  * I am not sure if HEAD:link that points at HEAD:link should be
> >> >>    reported as "missing".  It may be better to report the original
> >> >>    without any dereferencing just like a link that points at outside
> >> >>    the tree? i.e. "symlink 4 LF link".
> >> >
> >> > Unfortunately, a symlink loop might include relative symlinks
> >> > (e.g. ../a).  If we return a relative symlink, the user will
> >> > not be able to distinguish it from a non-loop, out-of-tree symlink.  So
> >> > I think we may not return symlink 4 LF ../a for these cases.  
> >> 
> >> I do not follow.  Let's start from a shared example.
> >> 
> >>     HEAD:sub/link is a symbolic link whose value is ../nextlink
> >>     HEAD:nextlink is a symbolic link whose value is sub/link
> >> 
> >> That's a loop.  Now, I think what I am sugesting is
> >> 
> >> 	$ git cat-file --batch-check --follow-symlinks <<\EOF
> >> 	HEAD:sub/link
> >>         HEAD:nextlink
> >> 	EOF
> >> 	symlink ../nextlink
> >>         symlink sub/link
> >> 
> >> If you asked about sub/link and then got ../nextlink back, then
> >> isn't it clear for the reading script that it is about nextlink
> >> at the top-level?  Why can't it tell it from out-of-tree link?
> >
> > Because maybe sub/link was actually a link to ../../nextlink.
> 
> Then the output would have said "symlink ../../nextlink" and you can
> tell these two cases apart, no?  Same for the other case.

No.  Successfully resolved out-of-tree symlinks must be relative to the
tree root.  Jeff King and I discussed this in the original RFC:
otherwise, after a chain of symlinks which might move you all over the
tree, you have no idea what "../" is relative to.
