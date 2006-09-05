From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pack-objects: re-validate data we copy from elsewhere.
Date: Tue, 05 Sep 2006 01:12:35 -0700
Message-ID: <7vr6yqivf0.fsf@assigned-by-dhcp.cox.net>
References: <20060830015122.GE22935@spearce.org>
	<9e4733910608291958l45c0257dla6e5ebd4176f7164@mail.gmail.com>
	<20060830031029.GA23967@spearce.org>
	<Pine.LNX.4.64.0608300124550.9796@xanadu.home>
	<7vzmdmh2lu.fsf@assigned-by-dhcp.cox.net> <44F871BA.3070303@gmail.com>
	<Pine.LNX.4.64.0609011129270.27779@g5.osdl.org>
	<7vveo741tc.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609011721390.27779@g5.osdl.org>
	<7vd5ae3ox2.fsf@assigned-by-dhcp.cox.net>
	<20060902045246.GB25146@spearce.org>
	<7vodty1swz.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609021720500.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 10:12:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKW2d-000442-G9
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 10:12:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWIEIMK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 04:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWIEIMK
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 04:12:10 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:47841 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932174AbWIEIMH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 04:12:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060905081207.UTQL6711.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>;
          Tue, 5 Sep 2006 04:12:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JYC71V00k1kojtg0000000
	Tue, 05 Sep 2006 04:12:08 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609021720500.27779@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 2 Sep 2006 17:27:48 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26466>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 2 Sep 2006, Junio C Hamano wrote:
>> 
>> repack without -a essentially boils down to:
>> 
>> 	rev-list --objects --all --unpacked |
>>         pack-objects $new_pack
>> 
>> which picks up all live loose objects and create a new pack.
>> 
>> If rev-list had an extention that lets you say
>> 
>> 	rev-list --objects --all --unpacked=$active_pack |
>> 	pack-objects $new_pack
>
> I have to say, that adding another pack-objects-specific flag to rev-list 
> doesn't necessarily strike me as very nice.
>
> It might be much better to just teach "git pack-objects" to walk the 
> object list by hand. The whole "git-rev-list | git-pack-objects" approach 
> made more sense back when git-rev-list was the _only_ think listing 
> objects, but now that we've librarized the whole object listing thing, 
> maybe it's time to avoid the pipeline and just do it inside the packer 
> logic.
>
> Of course, having git-pack-objects be able to take input from stdin is 
> still useful, but I'd rather start moving the obviously packing-specific 
> flags out of git-rev-list, and into git-pack-objects instead.
>
> [ That would also potentially make packing more efficient - right now the 
>   "phase 1" of packing is literally to just figure out the type and the 
>   size of the object, in order to sort the object list.
>
>   So when you do a big repack, first "git-rev-list" ends up doing all this 
>   work, and then "git-pack-object" ends up _redoing_ some of it. 
>
>   Especially for tree objects (which are one of the most common kinds), we 
>   already opened the object once when we traversed it, so opening it again 
>   just to look at its size is kind of sad.. ]

Well, I tried (see two patches from tonight, and the result is
sitting in "pu"), but it turns out that the information
pack-objects wants to get in check_object() is somewhat
different from what "struct object" family is willing to give
back easily during the traversal done by get_revision()
interface.

Since "struct object" traditionally has not had provision of
recording size (created_object() interface just takes sha1
without size, for example), and it was slimmed down to contain
absolute minimum information, I am reluctant to add fields to
record the size there.  Also having in-pack size available would
be rather nice but the functions involved in the call chain
(including process_tree and process_blob) did not even care
where the objects are stored, so it would involve rather nasty
surgery.  So I stopped short of that.  I am not quite sure how
useful tonight's patches are in practice.  It gets rid of the
pipe, but moves the revision walker memory pressure from rev-list
to pack-objects itself, so...
