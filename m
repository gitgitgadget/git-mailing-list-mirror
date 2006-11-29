X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Wed, 29 Nov 2006 20:00:22 +0000
Message-ID: <200611292000.23778.andyparkins@gmail.com>
References: <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <200611281335.38728.andyparkins@gmail.com> <20061129160355.GF18810@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 29 Nov 2006 20:03:30 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LS2OI1Z+SOjtVu0X22zg4CGR5HL5CDnbPcJPu/hxGQNMfbaAjolNr1IRf4OhrMUhBAhtXBepYB83FGSw164m4HE73/I1I88A8KzDFiPelLlbWb8x8ZF1hXPBfv2Zv8JtwDrREzF/22+O6JjWLaoZ40p5ecEc5UuZFnMK+sL82QI=
User-Agent: KMail/1.9.5
In-Reply-To: <20061129160355.GF18810@admingilde.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32661>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpVeG-0000d9-84 for gcvg-git@gmane.org; Wed, 29 Nov
 2006 21:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935996AbWK2UDN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 15:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936007AbWK2UDM
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 15:03:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:48050 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S935996AbWK2UDL
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 15:03:11 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1898497uga for
 <git@vger.kernel.org>; Wed, 29 Nov 2006 12:03:08 -0800 (PST)
Received: by 10.67.92.1 with SMTP id u1mr2713590ugl.1164830587995; Wed, 29
 Nov 2006 12:03:07 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164]) by
 mx.google.com with ESMTP id k30sm22506410ugc.2006.11.29.12.03.06; Wed, 29 Nov
 2006 12:03:07 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Wednesday 2006, November 29 16:03, Martin Waitz wrote:

> The way I wanted to address this is to show in the supermodule
> git-status that the submodule is using another branch.
> That way you are warned and can decide not to commit the supermodule.

The problem I see with tracking a particular branch is that it makes it less 
convenient to use git's quick-branching features in the submodules.  Let's 
say I want to try something out quickly in a submodule, I make a branch, 
commit, commit, "hmm, looks good, let's snapshot it in the supermodule", make 
a supermodule branch, "oh no, I've got to tell the supermodule to track the 
new (but temporary) branch in the submodule do a commit, switch the submodule 
branch back to master, delete the temporary branch, remember that the 
supermodule is tracking that branch and tell the supermodule to track 
something else instead...  It all seems too complicated to me.

> Pro HEAD:
>  - update-index on submodule really updates the supermodule index with
>    a commit that resembles the working directory.

Ouch.  Why does the submodule need to update the supermodule index?  That 
should be done by update-index in the supermodule.   Further, how is the 
supermodule index going to represent working directory changes in the 
submodule?  The only link between the two is a commit hash.  It has to be 
like that otherwise you haven't made a supermodule-submodule, you've just 
made one super-repository.  Also, if you don't store submodule commit hashes, 
then there is no way to guarantee that you're going to be able get back the 
state of the submodule again.

> Contra HEAD:
>  - HEAD is not garanteed to be equal to the working directory anyway,
>    you may have uncommitted changes.

That's the case for every file in a repository, so isn't really a worry.  It's 
the equivalent of changing a file and not updating the index - who cares?  As 
long as update-index tells you that the submodule is dirty and what to do to 
clean it, everything is great.

>  - when updating the supermodule, you have to take care that your
>    submodules are on the right branch.
>    You might for example have some testing-throwawy branch in one
>    submodule and don't want to merge it with other changes yet.

What is the "right" branch though?  As I said above, if you're tracking one 
branch in the submodule then you've effectively locked that submodule to that 
branch for all supermodule uses.  Or you've made yourself a big rod to beat 
yourself with everytime you want to do some development on an "off" branch on 
the submodule.

> Pro refs/heads/master:
>  - the supermodule really tracks one defined branch of development.

Why is this a pro?

>  - you can easily overwrite one submodule by changing to another branch,
>    without fearing that changes in the supermodule change anything
>    there.

You can always do that anyway by simply not running update-index for the 
submodule in the supermodule.

> Contra refs/heads/master:
>  - after updating the supermodule, you may not have the correct working
>    directory checked out everywhere, because some submodules may be on a
>    different branch.

This seems like the biggest problem to me - doesn't this negate all the 
advantages of a submodule system?  After a check in, you have no idea if what 
you checked in was what was in your working tree.


Andy

-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
