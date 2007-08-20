From: David Kastrup <dak@gnu.org>
Subject: Re: confused about preserved permissions
Date: Mon, 20 Aug 2007 20:44:08 +0200
Message-ID: <86r6lygi6f.fsf@lola.quinscape.zz>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net>
	<20070820174142.GA7943@glandium.org>
	<867inqhyuk.fsf@lola.quinscape.zz>
	<20070820181357.GA8264@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 20 20:45:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INCFI-0008Sy-C8
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 20:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbXHTSob (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 14:44:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbXHTSob
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 14:44:31 -0400
Received: from main.gmane.org ([80.91.229.2]:56853 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774AbXHTSoa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 14:44:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1INCEf-0002Hc-7m
	for git@vger.kernel.org; Mon, 20 Aug 2007 20:44:21 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 20:44:21 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Aug 2007 20:44:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
In-Reply-To: <20070820181357.GA8264@glandium.org> (Mike Hommey's message of "Mon\, 20 Aug 2007 20\:13\:57 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:MrjqnUqwKByl+y8RnLhfQhTvVTg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56238>

Mike Hommey <mh@glandium.org> writes:

> On Mon, Aug 20, 2007 at 07:58:43PM +0200, David Kastrup <dak@gnu.org> wrote:
>> > I also never understood why there were no permissions set on
>> > directories in trees...
>> 
>> Because directories are not actually tracked.  They are created and
>> deleted as-needed.
>
> I don't see why it would prevent to have a permission set to
> it... the permission technically can be recorded in the parent tree,
> along its sha1. Filesystems are also like this.

No, they aren't.  Filesystems don't create and delete directories on
the fly.  If we record any information about a directory, deleting it
automagically would not be appropriate since we would lose information
that has not been explicitly deleted.

>> Other permissions would correspond to a tracked directory.  I am still
>> stuck over the representation in the index.
>> 
>> One idea is to unconditionally have an entry "dirname" without
>> permissions, and optionally "dirname/" with permissions iff the
>> directory is supposed to be tracked, both to be sorted in
>> alphabetically.  The idea of the first entry is being able to detect
>> merge conflicts without extra passes.
>> 
>> But I have not worked on the stuff for a while.
>
> I don't see why you would need an additional entry for the directory
> permission.

One doesn't.  It would be just there to facilitate single-pass
detection of merge conflicts.  No non-redundant information content to
it at all, but it delivers the "we'll need a directory here"
information earlier in the sort order.

But one can probably do without that by just stashing away
non-directory entries namex* possibly colliding with a tree until the
opportunity for namex/* has passed by, and then processing them.  That
makes for a cleaner index format.

There is still the question when one stores just a single entry
whether to sort this under "namex" or "namex/" and whether to also
have it appear when it corresponds to a non-tracked directory.

It does not really make sense settling on one format before one
implements the various merge/update/checkout utilities since then one
sees what is most convenient.

>> > nor why, while the sha1 for child objects are "packed", the modes
>> > aren't...
>> 
>> Because a change of the mode of a file will then not cause different
>> sha1 sums at the file level.
>
> I think i wasn't clear enough... I just wondered why the format for tree
> entries is something like (if you'd write it in perl):
> sprintf "%06o %s\0%s", $mode, $file, pack("H[40]", $sha1)

Now I am sure I don't get your point.

-- 
David Kastrup
