From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: RFC/RFH submodule handling in big setups
Date: Mon, 7 Jan 2008 20:08:38 +0000
Message-ID: <320075ff0801071208u1900bf76q2f0dc9cb0dc4318b@mail.gmail.com>
References: <20080107102327.GA12427@pvv.org>
	 <7vr6gtzaeq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Finn Arne Gangstad" <finnag@pvv.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 21:09:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JByHW-0005uu-H5
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 21:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331AbYAGUIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 15:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753259AbYAGUIm
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 15:08:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:32620 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752709AbYAGUIl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 15:08:41 -0500
Received: by ug-out-1314.google.com with SMTP id z38so3201676ugc.16
        for <git@vger.kernel.org>; Mon, 07 Jan 2008 12:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2Bud5wNe6OcXHJGY9oamcOflGp/DRceZAJojqp8IDzw=;
        b=smGU5iwyoqKuIGrCQPePxjQ3V+IBBBlQ2xRFqo8DqX1AHfTxwk1VjkrJneSj2OvF3VPFsPiWCQzOFdA/ISdoU3WyZROQjl5X2+lG2Y+J6hgbUc7AilxzALBTPxiYbT8Lmu8dHOCsOJEhOr/7vRZKOe4gvJL3evcIelHOiV53K48=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aaiJ5ttysg8HMd4tk2U0izsRlKSqtLrqaYqcmo16zwhWc8lj+ms2NWYZcRFL+6QE+gTeRm2TisSWrM7yOoOPVNzMAU0VL/JuDZSSYkDrlxUFYV7vxug6WlZ9W0maL4z3Mp0G9Q0uM/MknmT3K9TbwV76ahysKLxdNo5Eh4/Gg3c=
Received: by 10.67.22.14 with SMTP id z14mr166413ugi.24.1199736518073;
        Mon, 07 Jan 2008 12:08:38 -0800 (PST)
Received: by 10.66.243.3 with HTTP; Mon, 7 Jan 2008 12:08:38 -0800 (PST)
In-Reply-To: <7vr6gtzaeq.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69803>

Do you currently use svn?
This feels like the common technique of using svn:externals, where
product1 has
foo repo/foo/trunk
os-abstraction-lib repo/os-abstraction-lib/trunk

product2 has
os-abstraction-lib repo/os-abstraction-lib/trunk
log-merger repos/log-merger/trunk

Where git (if I understand submodules correctly) can't do the above,
because the links are to SHA1s rather than tags or names, so in svn
terms it'd be something like
os-abstraction-lib repo/os-abstraction-lib/trunk@xxx
log-merger repos/log-merger/trunk@yyy

At first I thought the option (4) you suggest (Manually push all
sub-modules to some new branch before pushing the  super-module) was
going to be a pain - but actually I came to the conclusion it was
actually better. In our svn world, commits to shared libraries (can)
cause all hell to break loose - it'd actually be an advantage to have
to promote changes into the supermodules (the products in our case).




On Jan 7, 2008 7:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Finn Arne Gangstad <finnag@pvv.org> writes:
>
> > We're trying to get git to work well with our vision of submodules,
> > and have to figure out how to make submodule fetching and pushing work
> > in a smooth way.
> >
> > This is our situation (simplified):
> >
> >           [product1]          [product2]  ...         (supermodules)
> >            /      \             /     \
> >     ... [foo]  [os-abstraction-lib] [log-merger] ...  (submodules)
> >
> >
> > A developer does a modification to the os-abstraction-lib, and a
> > modification to the log-merger that depends on the change in the
> > os-abstraction-lib. He wants this into product2, and doesn't know or
> > care about product1.  He doesn't know whether his modification is
> > acceptable or not, or whether his modification will go in before some
> > other modification.
> >
> > He needs some way of pushing his modifications to a branch in the
> > supermodule (e.g. "change-131345"), without interfering with anyone
> > else.  The problem is where to push the sub-modules, they need to be
> > available for anyone who wants to get the "change-131345" branch of
> > the product2, but the modifications shouldn't show up anywhere else
> > (yet).  Here are solutions we have thought of so far:
>
> The phrase "without interfering with anyone else" feels somewhat
> wrong and I sense there is something missing in the description
> of the workflow.  When a developer pushes a change to somewhere
> else, it must be because the change needs to be shared with
> _somebody else_ (but not necessarily with _everybody_).
>
> Without knowing exactly what the desired workflow is, I'd hazard
> a guess and would recommend something else, which is  hopefully
> a more useful way.
>
> When the developer makes that 131345 change in os-lib submodule,
> he is acting as a developer of that library and advancing its
> state.  He wants to add an enhancement so that a particular way
> to use it elsewhere (his use in log-merger program perhaps being
> the first one of them) can be supported, but the change is not
> accepted as the project wide one from os-lib project's point of
> view.  The change needs to be shared with people in product2
> group that want to further work on top of the change he makes in
> log-merger project, but not necessarily with everybody in
> product2 group, let alone people in product1 group.
>
> That's exactly what a topic branch is about, isn't it?
>
> He has a topic to enhance something in os-lib project, so
> whatever the mysterious 131345 can be made into one branch in
> os-lib project and given a more meaningful topic name.  He can
> push that out to os-lib project, and bind its tip in his tree of
> product2 superproject at os-lib directory, and push it to
> produc2 repository (maybe to its 'master', or maybe also to its
> one of the topic branches that houses his work-in-progress).
>
> That way, when somebody from product2 group needs to work on top
> of the change he made and pushed out thusly updates, his copy of
> os-lib will get the updates to (or perhaps creation of) the
> topic branch that contains 131345 change, and he can start
> working from where the original developer left off.  He can even
> fix bugs in the change in that 131345 topic in os-lib project
> the original developer made, push that back, and the original
> developer can build on top of that change.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
