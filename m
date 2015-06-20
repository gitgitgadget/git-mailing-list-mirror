From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] upload-pack: Fail if cloning empty namespace
Date: Sat, 20 Jun 2015 14:20:24 -0700
Message-ID: <xmqqmvzujcvb.fsf@gitster.dls.corp.google.com>
References: <1434140115-3139-1-git-send-email-johannes@kyriasis.com>
	<1434147436-21272-1-git-send-email-johannes@kyriasis.com>
	<20150612223223.GA22677@leeloo.kyriasis.com>
	<xmqqh9q87l3x.fsf@gitster.dls.corp.google.com>
	<20150620142705.GA23163@leeloo.kyriasis.com>
	<xmqqr3p6jltx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes =?utf-8?Q?L=C3=B6thberg?= <johannes@kyriasis.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 23:20:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6QBn-00089R-0W
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 23:20:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754572AbbFTVU3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2015 17:20:29 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:32860 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbbFTVU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2015 17:20:27 -0400
Received: by ieqy10 with SMTP id y10so5635058ieq.0
        for <git@vger.kernel.org>; Sat, 20 Jun 2015 14:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=2B/xH35aHVN+kted49pKvenXbojnO5GFc6a5HSlcMiA=;
        b=qqRgLpImSoI3tUz9ErmvrbNAXiq57k/3zU+xIInhPX2YFTGhSjm4DBrcYSvVspTck9
         9OkodrSJX0lR0NzntK/jkTOVZzZARnk0UCU4lSd10lTU4V7/QGpcVOZF9XOw1od2yAtm
         jYsicDOmhpgVNJeRhSOwjIwzYaZZtTiT8c4Ph1ZXaVNDzx4vjvaEy9mg3T80w4vGPAut
         L6Nna1w0ehS2ikXKx00V8iC7yVtFlJxfv8IKCESVgN2xDfDT6dNebXqUoinZxlu1mMUN
         ZeBueNAqRFHnre+QeZe9G53PpsEjPss85YrtHGock6HuL90HrCWZ8W3/I+I7GpwByYBl
         IgNA==
X-Received: by 10.42.43.199 with SMTP id y7mr18502764ice.12.1434835226689;
        Sat, 20 Jun 2015 14:20:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f44b:8ca4:e732:8441])
        by mx.google.com with ESMTPSA id t7sm4428919ign.8.2015.06.20.14.20.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 20 Jun 2015 14:20:25 -0700 (PDT)
In-Reply-To: <xmqqr3p6jltx.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Sat, 20 Jun 2015 11:06:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272240>

Junio C Hamano <gitster@pobox.com> writes:

>> You create a namespace by pushing to it,...
>
> You keep repeating that, but I do not think we agreed that it is the
> supported or correct procedure to set up a new namespace in the
> first place.  Doesn't the server side need a lot more than just
> setting up HEAD symref (like running upload/receive-pack with the
> path to the hierarchy exported as GIT_NAMESPACE environment)?

Let me step back and try again, as I think I am missing some
existing feature you are using, and that missing piece is preventing
me from seeing why this is a good idea (by the way, I do not think
we are doing this exchange in the right thread---the upload-pack
patch is not about auto-vivifying a new namespace by creating HEAD).

I'll do a brief braindump which hopefully shows the basis of why I
keep saying that creating HEAD at random place is not sufficient.
Help me, by telling me what I am missing, understand why it is
sufficient.

Suppose we have a server at URL git://site.xz/r; it serves from the
filesystem, say /usr/share/git/r.git/ (bare repository).  In that
directory, we have the usual HEAD, objects, refs/{heads,tags}, etc.
Further suppose we have there refs/namespaces/a/ under which HEAD,
refs/{heads,tags}, etc.

Then we run the server (say, git-daemon) with GIT_NAMESPACE
environment variable set to 'a'.  The users can now run:

 $ git clone git://site.xz/r

and they will see what's really under refs/namespaces/a/.  The HEAD
they see is actually not /usr/share/git/r.git/HEAD but it is
/usr/share/git/r.git/refs/namespaces/a/HEAD.  Everything outside
/usr/share/git/r.git/refs/namespaces/a is not visible to them.

In order to add a new namespace 'b' next to 'a', you would somehow
need to populate /usr/share/git/r.git/refs/namespaces/b.  Presumably
you can prepare a source repository locally and then push everything
there manually, by doing something like this:

 $ git push ssh://site.xz/usr/share/git/r.git refs/*:refs/namespaces/b/*

but we agree that this does not create refs/namespaces/b/HEAD.

But if we made some change to the transfer to push-to-receive-pack
so that this can also create HEAD that points at something, what
would the user say, instead of that earlier

 $ git clone git://site.xz/r

to access this new namespace?  Don't you have to be running another
instance of a server with GIT_NAMESPACE set to 'b'?  How do you
arrange that to automagically happen?

Or do your users that clone/fetch do things differnetly from the
above, and if so what do they do?

How is your server configured to support the access the existing
namespace 'a', and the new namespace 'b' that is automatically
created by pointing /usr/share/git/r.git/refs/namespaces/b/HEAD
to one ref inside that namespace?
