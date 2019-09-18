Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E37821F463
	for <e@80x24.org>; Wed, 18 Sep 2019 20:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387478AbfIRUq7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Sep 2019 16:46:59 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:54915 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfIRUq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Sep 2019 16:46:58 -0400
X-Originating-IP: 1.186.12.28
Received: from localhost (unknown [1.186.12.28])
        (Authenticated sender: me@yadavpratyush.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B6AD960004;
        Wed, 18 Sep 2019 20:46:55 +0000 (UTC)
Date:   Thu, 19 Sep 2019 02:16:53 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: git-gui: duplicated key binds?
Message-ID: <20190918204653.jxzirmmmauf52wn7@yadavpratyush.com>
References: <CAGr--=KC=OPMJZB883MWys=J068cdZNHL=eOYK81fNBEv9MhvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr--=KC=OPMJZB883MWys=J068cdZNHL=eOYK81fNBEv9MhvA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/09/19 01:24PM, Birger Skogeng Pedersen wrote:
> Hi,
> 
> 
> It looks to me like there are a lot of key binds duplicated in the
> git-gui source.
> 
> For instance, Ctrl/Cmd+Enter are bound in two lines:
> bind $ui_comm <$M1B-Key-Return> {do_commit;break}
> and
> bind .   <$M1B-Key-Return> do_commit
> 
> I guess the first one is specified to work in the commit message
> widget. The second one is for all widgets(?).

Yes, but in this case they are doing the same thing.

Actually, this is a bit of a mess that shouldn't exist in the first 
place.

According to the bind manual page [0], 

  It is possible for several bindings to match a given X event. If the 
  bindings are associated with different tag's, then each of the 
  bindings will be executed, in order. By default, a binding for the 
  widget will be executed first, followed by a class binding, a binding 
  for its toplevel, and an all binding.

  The continue and break commands may be used inside a binding script to 
  control the processing of matching scripts. If continue is invoked, 
  then the current binding script is terminated but Tk will continue 
  processing binding scripts associated with other tag's. If the break 
  command is invoked within a binding script, then that script 
  terminates and no other scripts will be invoked for the event.

What this essentially means is that first the binding for $ui_comm is 
executed, and then the binding for ".". But since the binding for 
$ui_comm has a break, only the first one is executed, and not the 
second. This is what happens when the focus is in $ui_comm.

If the focus is elsewhere, the second binding (the one for ".") is 
executed.

My point is, a break for something so simple should not be there in the 
first place. If you do want Ctrl+Enter to make a commit from anywhere, 
don't specify the binding for it in $ui_comm. So in this case IMO the 
break is a simple hack to prevent do_commit from being executed twice.

Now on the more subjective side, is it really a good idea to allow 
Ctrl+Enter to commit from anywhere? IMHO it should only do that from the 
commit message buffer.
 
> Also, I see that some binds are with the "all" tag, while most are
> with just a dot as tag.

Ah, more of this bind mess. Luckily for us only places where "all" is 
used is for binds that quit the application. So it shouldn't be too much  
a problem.

Now for the dirty details:

Excerpt from the bind manual page:

  - If the tag is the name of a toplevel window the binding applies to 
    the toplevel window and all its internal windows.

  - If tag has the value all, the binding applies to all windows in the 
    application.

As far as I understand, binds for "." are executed for every child 
window of the toplevel window "." (aka the main widow). Examples for 
children of "." include the diff viewer, the commit message buffer, etc. 

Now this is where my understanding of this gets shaky. If you bind 
Ctrl-W to quit the window, then in that case every child window of "." 
should have the same behaviour in that binding. But that is not the case 
for, say, the "Options" dialog.

The Options dialog is a toplevel window itself (all dialogs are), but it 
is called ".options", so one would assume it should be a subwindow for 
".". That does not appear to be the case.

But we do want Ctrl-W to work on the options dialog too (and the tools 
dialog, and all other dialogs). So, the binds for Ctrl-W should stay 
bound to "all". Same argument can be applied to Ctrl-Q.
 
> Is this a mistake (aka something I could write a patch for)? Or am I
> just missing something?

I haven't got the time right now to look at all the duplicate bindings, 
but at least for the Ctrl-Enter one, it is debatable whether it is a 
bug.

If people think having this binding active for only the commit message 
buffer, then it is a bug, and the binding for "." should be removed. I 
am one of those people.

But if people think that Ctrl-Enter should trigger a commit _anywhere_ 
in the UI, then it is fine as it is.

I will try to look at other duplicates tomorrow.
 
> I propose:
> - replace "bind .   " with "bind all "

Like I mentioned above, "bind ." and "bind all" are not the same thing. 
In our case, the main problem is with dialogs. They have a different 
toplevel window than the main program. So if we do replace "bind ." with 
"bind all", then the bindings for things like commit, rescan will also 
move over to those dialogs. I don't think it is a good idea to do so.

> - remove duplicated bind entries, if a key is bound to "all" then it
> shouldn't be bound with another tag

From my quick scan of the search results for "bind", the only keys bound 
to "all" are "Q" and "W". "Q" quits the entire application, and "W" 
closes the current toplevel window. Both should stay the way they are.

As for duplicated bindings for ".", and other widgets, that is something 
I haven't looked into too well. I will get to it by tomorrow.

[0] https://www.tcl.tk/man/tcl8.4/TkCmd/bind.htm

-- 
Regards,
Pratyush Yadav
