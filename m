X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [RFC] Teach git-branch howto rename a branch
Date: Sat, 25 Nov 2006 09:52:45 +0100
Message-ID: <8c5c35580611250052k19bf54aelcc3833506c2a09f9@mail.gmail.com>
References: <1164409429445-git-send-email-hjemli@gmail.com>
	 <7v1wns6q41.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sat, 25 Nov 2006 08:52:56 +0000 (UTC)
Cc: git@vger.kernel.org, "Shawn Pearce" <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OQ7AWSfav7M22i4aeui9xgj5GT0oTGNISfy5SneRcpX/a+3NLV9kDyx5A7R5zoPTh/VZ8hhNcqFQEcN+fGc9yqztYwKSMbnDB0TNDVXIOkxIG155lKIuzUMIP5l4sn10/QN7v5jKPX9KIHku4PwpMjqz7hkfuLwM36TIhT85NH4=
In-Reply-To: <7v1wns6q41.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32269>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GntHH-0006C4-E4 for gcvg-git@gmane.org; Sat, 25 Nov
 2006 09:52:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933996AbWKYIws (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 03:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934217AbWKYIws
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 03:52:48 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:35151 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S933996AbWKYIwr
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 03:52:47 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1506116nfa for
 <git@vger.kernel.org>; Sat, 25 Nov 2006 00:52:46 -0800 (PST)
Received: by 10.82.190.2 with SMTP id n2mr1695703buf.1164444765807; Sat, 25
 Nov 2006 00:52:45 -0800 (PST)
Received: by 10.82.171.10 with HTTP; Sat, 25 Nov 2006 00:52:45 -0800 (PST)
To: "Junio C Hamano" <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On 11/25/06, Junio C Hamano <junkio@cox.net> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
>
> > +static void rename_branch(const char *newname, const char *oldname, int force, int reflog)
> > +{
> > +     char ref[PATH_MAX];
> > +
> > +     snprintf(ref, sizeof ref, "refs/heads/%s", oldname);
> > +     if (check_ref_format(ref))
> > +             die("'%s' is not a valid branch name.", oldname);
> > +
> > +     newname = create_branch(newname, oldname, force, reflog);
>
> This does not feel right.  The 'start' parameter to
> create_branch is arbitrary SHA-1 expression so it can take
> 'master', 'heads/master' and 'refs/heads/master' to mean the
> same thing, as long as they are unambiguous, but here you would
> want to accept only 'master' because the paramter is supposed to
> be the name of the branch you are renaming.  create_branch()
> does not want to do that check for its start parameter, so you
> should do the checking yourself here, and check_ref_format() is
> not good enough for that.  Probably calling resolve_ref() on ref
> (= "refs/heads/oldname") for reading (because you also want to
> make sure oldname talks about an existing branch) is needed.

I forgot to use the handcrafted ref when calling 'create_branch':

   newname = create_branch(newname, ref, force, reflog);

This would force the 'refs/heads' prefix, but let 'create_branch'
check if it's a valid commit reference. I _think_ this would be good
enough....


>
> > +     if (!strcmp(oldname, head)) {
> > +             create_symref("HEAD", newname);
> > +             head = newname + 11;
> > +     }
> > +     delete_branch(oldname, force, NULL);
> >  }
>
> What is the right thing that should happen when newname talks
> about an existing branch (I am not asking "what does your code
> do?")?
>
> Without -f, it should barf.  With -f, we would want the rename
> to happen.  In the latter case, I think it should work the same
> way as deleting it and creating it anew, and that would make
> sure that reflog for the old one will be lost and a new log is
> started afresh; otherwise, the log would say old history for
> that branch and it won't be a "rename" anymore.

Yes, the missing piece here is to copy the 'old' reflog to it's new
location after the call to create_branch. I belive create_branch
handles the -f cases.


> Also what happens when oldname is "frotz" and newname is
> "frotz/nitfol"?  You would need to read the value of "frotz",
> make sure you can delete it (perhaps the usual fast-forward
> check as needed), and delete it to make room and then create
> "frotz/nitfol".  I suspect your patch does not handle that
> case.

Hmm, you're right, I didn't think of such renaming. But I don't want
to delete the old ref before the new one is in place. How about
renaming the old one to a temporary name first?


I'l redo the patch on top of your 'git-branch -D' fix

-- 
