From: Imre Simon <is@ime.usp.br>
Subject: [RFC] A suggestion for more versatile naming conventios in the object
 database
Date: Thu, 21 Apr 2005 16:51:31 -0300
Message-ID: <42680443.3050604@ime.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 21 21:46:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOhcY-0001ne-Lt
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 21:45:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVDUTuR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 15:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVDUTuQ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 15:50:16 -0400
Received: from smtpout2.uol.com.br ([200.221.4.193]:8610 "EHLO smtp.uol.com.br")
	by vger.kernel.org with ESMTP id S261822AbVDUTuC (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 15:50:02 -0400
Received: from [192.168.0.7] (201-1-98-36.dsl.telesp.net.br [201.1.98.36])
	by scorpion2.uol.com.br (Postfix) with ESMTP id 04A897D4B;
	Thu, 21 Apr 2005 16:49:59 -0300 (BRT)
User-Agent: Mozilla Thunderbird 1.0RC1 (Macintosh/20041201)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In the transition from git-0.04 to git-0.5 (Linus' track) the naming 
convention of files in the object database has been changed: a file's 
name passed from the sha1 of its contents to the sha1 of its contents 
*before* compression.

This change was preceded by a long discussion hence both conventions
have arguments for and against.

I would like to suggest to adopt a more versatile solution:

   preserve the pure sha1 based names for the sha1 sum of the file's
   contents. I mean,

       (*)  for files with name xy/z{38} their sha1 sum is xyz{38}

   allow other files (or links) with names of the form

       xy/z{38}.EXTENSION

   where for every EXTENSION the file's content would be the EXTENSION
   representation of the file xy/z{38} . For every representation type
   EXTENSION there should be procedures to derive the file xy/z{38}
   from the name xy/z{38}.EXTENSION and vice-versa (assuming that the
   representation type EXTENSION cares about the contents of file
   xy/z{38}).

Let me give two examples:

    all the files in the object database of git-0.04 are just fine, they
    satisfy axiom (*)

    the name of every file xy/z{38}  in the git-0.5 data base should be
    changed to xy/z{38}.g assuming that we will use EXTENSION g as the
    git representation type. The conversion algorithms would be:

        cat-file `cat-file -t xyz{38}` xyz{38}  to obtain the contents
        represented by xy/z{38}.g whose sha1 is xyz{38}

        and a utility program has to be written to check whether a given
        file F, is a valid contents as far as git is concerned and in
        case it is compute its sha1 sum xyz{38} and also comute the file
        the file xy/z{38}.g .

So, what are the advantages of this further complication? I see these ones:

   git is separated from the idea of sha1 addressable contents, which
   indeed is an idea larger than git itself. This same or similar
   addressing schemes can (and most probably will) be applied to other
   contents besides SCMs. An example would be a digital library of
   scientific papers in pdf together with its OAI compliant meta data
   (don't bother if you are not familiar with these terms, it is just
   an example and I am sure you are able to come up with many other
   examples where a sha1 addressable data base would be interesting)

   all these uses could share common backup schemes where axiom (*)
   would be enforced. One could think of a shared p2p database of
   repositories of sha1 addressed contents of all kinds. This might be
   important because, in general, the contents of xyz{38} cannot be
   reconstructed from its name. The way to defend against file system
   corruption is replication. Why not share these backup databases?

   it would be easier to experiment with other compression schemes or
   other proposals for meta data in git itself.

   it would be easier to experiment with the factorization of common
   chunks of contents, an idea very close to the secret of rsync's
   amazing efficiency.

Well, that's the proposal. I would be happy to hear comments!

Cheers,

Imre Simon

PS: the way it is, the git-0.5 README file is inconsistent. The naming
change is not reflected in the README file which in many places states
that the sha1 sum of file xy/z{38} is xyz{38}.

