From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Wed, 21 Nov 2012 09:37:26 +0100
Message-ID: <CAMP44s3_nMqJ_ieOxwtDXb4ou6pb7AFsX4tr45p97StT35=SKg@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
	<1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s0WH-P7WY4UqhMX3WdrrSCYXUR9yCgsUV+mzLOCK5LkHQ@mail.gmail.com>
	<7vd2z7rj3y.fsf@alter.siamese.dyndns.org>
	<20121121041735.GE4634@elie.Belkin>
	<7vfw43pmp7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 09:37:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tb5oV-0000Be-Cw
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 09:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583Ab2KUIh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 03:37:28 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52633 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824Ab2KUIh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 03:37:27 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so6786533obb.19
        for <git@vger.kernel.org>; Wed, 21 Nov 2012 00:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LmRlRoHQHJs6cy8h/cw36yuTrmGJXgHRhyOcSn7OK8U=;
        b=mM4p6hAkVQ3Rh9zV2NPGni8NC5hIEKH7insN42PA1NRT8SUlhrOUWT31wIU+mBEMW5
         rfuAdRCweIM9U29TDDr49T4EtvronV5ybjej4OsEaA774xutcy0ih0W0Kkau/c5Rt1qQ
         KRlFVahmpqobOdDd+21qByau5FY6jQG5VobynsChni0iGThaaUCoQKaiZPsb6kLycB6F
         D1i0LZWtmR1rUK0eRbQJPhwjut5xvQqKUQEyshpX/3bCMTZ44ga8HvPYaNJDxItpDNnn
         spUGgv7dUeGS4gi14shswXwPgZtA+qPKpSxZ94eQwVSmoJN3SKM3RYSMAAonhA/dYzUC
         1CrA==
Received: by 10.182.98.19 with SMTP id ee19mr15406259obb.90.1353487046839;
 Wed, 21 Nov 2012 00:37:26 -0800 (PST)
Received: by 10.60.28.232 with HTTP; Wed, 21 Nov 2012 00:37:26 -0800 (PST)
In-Reply-To: <7vfw43pmp7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210145>

On Wed, Nov 21, 2012 at 6:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Never mind that others have said that that's not the current interface
>> (I don't yet see why it would be a good interface after a transition,
>> but maybe it would be).  Still, hopefully that clarifies the intended
>> meaning.
>
> Care to explain how the current interface is supposed to work, how
> fast-export and transport-helper should interact with remote helpers
> that adhere to the current interface, and how well/correctly the
> current implementation of these pieces work?
>
> What I am trying to get at is to see where the problem lies.  Felipe
> sees bugs in the aggregated whole.  Is the root cause of the problems
> he sees some breakages in the current interface?  Is the interface
> designed right but the problem is that the implementation of the
> transport-helper is buggy and driving fast-export incorrectly?  Or is
> the implementation of the fast-export buggy and emitting wrong results,
> even though the transport-helper is driving fast-export correctly?
> Something else?

Let me give it a shot at explaining the case for remote helpers that
use export/import.

== listing ==

All operations begin with the transport helper requesting a list of
refs. Basically 'git show-ref'.

== fetching ==

In fetch mode the transport helper will initiate the process by
requesting refs to the remote helper, like 'master', or 'devel', and
so on. These refs were previously provided by the remote helper itself
in the "listing" step.

It is the total responsibility of the remote helper to decide what to
do: nothing, only update the ref pointers, retrieve the whole
repository, retrieve only the listed refs, etc. It's also the
responsibility of the remote helper to keep track of marks, last known
commits the refs pointed to, update local transitory repositories,
etc.

It's also the responsibility of the remote helper to throw the right
'feature' commands to fast-import for everything, including where to
store the marks.

Note that there are two sets of marks; the marks of the remote helper,
which could be anything: JSON, text files, binary, etc. and don't
contain git SHA-1's, and the git marks, which do contain git SHA-1's
and are exported/imported by fast-import, but *both* are totally under
control of the remote helper.

At this point, git (transport helper), has absolutely no idea what's
going on, the communication is completely between the remote helper
and fast-import. After this process has finished, control goes back to
the transport helper, which proceeds to check what fast-import did.

Then, the result is shown to the user as the typical fetch that
updated certain refs.

== pushing ==

In this mode the roles are reversed, now git (transport helper) is in
control, and everything that happens depends on what commands are
passed to fast-export. Now the remote helper is a passive receiver of
data, and has two options, receive it or die.

Which refs get updated and how, is the total responsibility of transport helper.

The only control the remote helper has, is before the export begins,
in the configuration (capabilities command) that happens at the very
beginning (before listing), and where it specifies features to
support, which are then used to pass the relevant arguments to
fast-export.

And these capabilities are very limited:
* import-marks
* export-marks
* refspec

After the push has finished, the remote helper then proceeds to report
which refs were actually updated, and the user gets notified.

== details ==

As it should be obvious by now, there's not many ways in which a
remote helper can screw things up (other than the parsing and
generation of data for fast-import/export). The only tricky part is
the refspec.

To function properly, a remote helper should specify a refspec such as
'refs/heads/*:refs/test/heads/*', this way, all the changes a remote
helper does are isolated in a specific refspec namespace, and the
update to normal git happens in a controlled way.

However, the refspec only makes sense in the *fetching* mode; the
remote-helper is supposed to throw updates in the form of 'commit
refs/test/heads/master', not 'commit refs/heads/master' (although in
some case that might work, but I'm not sure which).

But when pushing the remote helper will receive the refs in the normal
form 'refs/heads/master'. Also, the namespaced refs are only updated
when fetching, not when pushing.

Marks are very straightforward; the same import and export marks
should be specified for both importing and exporting.

Everything works mostly fine as long as the remote helper follows
this. Things break in all sorts of ways when it doesn't.

But I want to emphasize again that there's not many ways in which a
remote helper can screw things: marks, or refspec, that's it.
*Specially* when pushing.

== no marks ==

Let's imagine a very simple repository with 3 commits, which gets
pushed to a remote one:

4e891f6 :3
d9d17c3 :2
e1aef7b :1

I'm obviously simplifying the marks, but essentially that's what
fast-export would do when pushing commits to a remote helper; it the
parent of :2 is :1, and the parent of :3 is :2, but the remote side
*never* sees any git SHA-1, because they are not interesting in any
way, there's nothing useful that can be done with them.

The remote side would generate commits such as:

:3 103
:2 102
:1 100

Again, for simplification purposes (you can picture them as mercurial revs).

Now the push has finished. The marks are gone (no marks).

What happens when you fetch? You might think that we will get only the
commits after :3, but that's not the case, the transport helper would
use 'refs/test/heads/master' to find out the last commit, but that
doesn't get updated when pushing, only when fetching, so we would
start from the top.

4e891f6 :3
d9d17c3 :2
e1aef7b :1

:3 103
:2 102
:1 100

The same will happen if you push, because push also uses
'refs/test/heads/master'.

But *now* that we are doing a fetch, the 'refs/test/heads/master'
pointer is updated to 4e891f6. But don't think that those marks are
the same as the previous ones: they happen to be the same because they
were generated the same way, but they are completely independent.

What happens when you push now? Now the 'refs/test/heads/master' is
pointing to 4e891f6, and suppose we have two new commits:

88764ee
4607106
4e891f6 :3 <- I'm putting these for reference, but in reality they are gone
d9d17c3 :2
e1aef7b :1

The transport helper would do an export of '^refs/test/heads/master
refs/heads/master', or '^4e891f6 88764ee'. And here comes the
interesting part:

What is the parent of 4607106? It's not :3, because that mark is gone,
and in fact, even if we sent :3; things would break down because the
other side has no idea what :3 means; it's gone, caput. What really
happens is:

88764ee :2
4607106 :1

This is a new tree. That's exactly what you would expect if you do
'git fast-export ^v1.8.0^ master'; export all the commits as if v1.8.0
was the root.

But in the context of remote helpers, that's not what we want.

What can we do to fix this? Let's suppose that through some magic we
get the parent of 4607106 to be 4e891f6; is that helpful? No. To the
remote helper 4e891f6 is useless. What we need is 103, but without
marks, we can't find that out.

Maybe if we stored it in the last run? We need to parse the git marks,
and then match our marks with those, and we could get a mapping like
'4e891f6 -> 103', but what if the parent is 102? So, we need a mapping
for all the marks, and then we have to store such mapping anyway. And
guess what? We are back to using marks again! Except that instead of
using the standard git way, we are using a custom hacky way.

Are there other solutions? Maybe we can store the information in refs:

4e891f6 refs/test/ids/103
d9d17c3 refs/test/ids/102
e1aef7b refs/test/ids/100

But that also would require parsing the git marks, and going outside
of the intended fast-export tool would kind of defeat the purpose of
being fast an efficient, and still very hacky.

And lets not even go as to what would be needed for 'git fast-export'
to actually generate 4e891f6 in the first place, as that would
probably require changes that would break other things.

So no, you can't do it without marks.

And why are we even discussing about this? Why would anybody want to
avoid marks? Not only there's no other ways to achieve the same, marks
are cheap and efficient, as efficient as any other solution could be,
and then some. And do we have any real remote helpers that try to do
export/import without marks? No, heck, we don't even have fake ones.

It just doesn't work. Seriously.

And my patches actually make it work: if there are no marks, then
_everything_ is pushed. I don't see the point of supporting the
functionality of no marks, clearly nobody is using that because it
just doesn't work. Nobody has shown a shred of evidence to the
contrary. With my patches, at least we try to do something without
failing too miserably.

Cheers.

-- 
Felipe Contreras
