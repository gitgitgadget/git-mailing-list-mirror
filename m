From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [RFC] Plumbing-only support for storing object metadata
Date: Sun, 10 Aug 2008 16:50:19 +0200
Message-ID: <20080810145019.GC3955@efreet.light.src>
References: <20080809210733.GA6637@oh.minilop.net> <d411cc4a0808091449n7e0c9b7et7980cf668106aead@mail.gmail.com> <20080810035101.GA22664@spearce.org> <20080810112038.GB30892@cuci.nl> <alpine.DEB.1.10.0808100502530.32620@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Scott Chacon <schacon@gmail.com>,
	Jamey Sharp <jamey@minilop.net>,
	Josh Triplett <josh@freedesktop.org>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Aug 10 16:51:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSCGa-00052Y-FQ
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 16:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781AbYHJOu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 10:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753565AbYHJOu3
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 10:50:29 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:45977 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753237AbYHJOu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 10:50:28 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id ED1CB572CC;
	Sun, 10 Aug 2008 16:50:26 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id DEU-d+stx172; Sun, 10 Aug 2008 16:50:24 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id C4ECE572DD;
	Sun, 10 Aug 2008 16:50:22 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KSCFP-00023u-8z; Sun, 10 Aug 2008 16:50:19 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0808100502530.32620@asgard.lang.hm>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91841>

On Sun, Aug 10, 2008 at 05:16:47 -0700, david@lang.hm wrote:
> On Sun, 10 Aug 2008, Stephen R. van den Berg wrote:
>> However, pondering the idea a bit more, I could envision something
>> similar to the following:
>>
>> In the git tree the following layout would be used:
>>
>> plainfile.txt
>> otherdir/otherplainfile.txt
>> projects/README
>> projects/README/_owner
>> projects/README/_acl
>> projects/README/_icon
>> projects/README/_mimetype
>> projects/something.mpeg
>> projects/something.mpeg/_icon
>> projects/something.mpeg/_mimetype
>> projects/asubdir/thirdplainfile.txt
>>
>> That would imply that in the tree storage, the only extension would be
>> that for any given reference to a blob in a tree object, there could be
>> a reference to a tree object as well.  I.e. something like this in the
>> tree object:
>>
>> 100644 blob f7b7414159b8a7159538fac543b2b19ef531968e  README
>> 000000 tree df6ee415f04d6ccea5dab0de562c2f155583a2c4  README
>> 100644 blob 0a54f8ec13df03cf6bdb5b973acec6d8141c01cc  something.mpeg
>> 000000 tree a421448d765abb7bb979dc1d56621d0fc9b41229  soemthing.mpeg
>>
>> The extra tree reference for README would actually refer to something like:
>>
>> 100644 blob be3365fdaae0f4ed8c22c4cf38a4b1f88f9069c3  _owner
>> 100644 blob 739e9e8f3d095931084b54cbf7f90d8f64eb0ac6  _acl
>> 100644 blob bc1a868bb50644712966a50150d21199c401d6d5  _icon
>> 100644 blob 6076bde5b3b6b8bed4ec4968d09abdbf015b3b75  _mimetype
>>
>> Which would contain the extra attributes.

... provided the two entries under the same name wouldn't drive the internal
logic completely mad, I quite like this. Note by the way, that you need to
allow for two trees too, because you may want to store attributes for
directories too. It's no problem to differentiate them by type 04755
vs. 00000 or 11000 or whatever, but it is a problem for index, because that
does not store directory entries, so metadata for a directory would conflict
with regular entries in it. Can be fixed by using different filetype for the
metadata.

>> And that would imply that during checkout you can do a rich checkout or a
>> flat checkout for any files under the projects directory.
>>
>> A flat checkout results in the following files in the filesystem:
>>
>> plainfile.txt
>> otherdir/otherplainfile.txt
>> projects/README
>> projects/README.attr/_owner
>> projects/README.attr/_acl
>> projects/README.attr/_icon
>> projects/README.attr/_mimetype
>> projects/something.mpeg
>> projects/something.mpeg.attr/_icon
>> projects/something.mpeg.attr/_mimetype
>> projects/asubdir/thirdplainfile.txt

Storing like this in index as well would make it even more compatible. Of
course you are reserving the .attr suffix. But it's probably OK to reserve
/something/ for this functionality (when the functionality is needed only).
Maybe it could use some special character (@, #, =, $ or something) to
separate the suffix instead of normal . to decrease the chance to conflict
with other use.

>> A rich checkout results in the following files in the filesystem:
>>
>> plainfile.txt
>> otherdir/otherplainfile.txt
>> projects/README
>> projects/something.mpeg
>> projects/asubdir/thirdplainfile.txt
>> projects/asubdir/fourthplainfile.txt
>>
>> The rich checkout also applies the extended attributes/metadata to the
>> filesystem (i.e. it would store all the metadata in the appropriate
>> places).
>>
>> The nice thing about this setup is that:
>> a. There is *no* change whatsoever to existing repositories or
>>   repositoryformat.

Well, there is a small change -- it needs to support multiple entries with
different type but same name in the tree object (but could be avoided by
using some special reserved suffix). Plus the index functionality needs to be
modified to put the metadata entries in the right places. Still of course
much less invasive than the proposal from OP.

>> b. It's less filling (i.e. there are no special bits or object types to be
>>   used).
>> c. Speed for files without attributes is not affected.
>> d. It's fully 8-bit-transparent.
>> e. It scales, even if you have large or many attributes.
>> f. It uses the natural tree storage abstraction already supported in
>>   git repositories to store the additional data.
>> g. It allows reuse of attribute information at many levels.
>> h. It even allows for a hierarchy of attributes attached to a single
>>   file (no current filesystem supports that (yet)).
>> i. The only change in the fast-path of core-git is that it would have to
>>   know how to skip tree objects referenced in a tree object if a
>>   same-name blob object is already there.  This can even be optimised
>>   by requiring the attribute-tree to have a very specific (e.g. 0)
>>   mode to ease detection.
>> j. Editing and merging the meta-information could be made an almost
>>   natural operation in the flat-checkout mode (the extension to be used
>>   to name the attribute subdir should be made configurable).
>
> you also need to be able to add something to the attribute tree to  
> indicate what type of metadata is being stored in it. you could  have 
> *nix perms, windows perms, posix extended attributes, or other things.

Well, not really. I think the best way to implement the 'rich' checkout is to
use a hook to read/write the metadata. Git-core should just support storing
attributes, but not actually store any of it's own, since they are nt needed
for it's main purpose, which is source code control.

> I could see this as a great way to deal with editing exif data for 
> images. when checking in a .jpg, extract the .exif data and store it 
> seperately, when doing a rich checkout combine it back into the .jpg 
> file. now the large binary blob doesn't change so you don't have to try 
> and find deltas for it.
>
> all the special case things would be in the helper routines written to do 
> the 'rich checkin/checkout' of each type. people who don't care about  
> this don't enable these helpers in the configs and so don't suffer any  
> overhead (other then item (i) above)
>
> this has the potential to be horribly abused, but it also has the  
> potential to open up some very interesting possibilities as well.

I would say your example above belongs in the categry of abuses. The binary
differ can deal with exif just OK (it's not compressed IIRC), so all you need
is a custom diff driver for merging -- and that's already supported.
Compressed stuff can be already handled for the differ with clean & smudge.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
