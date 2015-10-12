From: Christian Gagneraud <chgans@gna.org>
Subject: Hacking git for managing machine readable "source" files
Date: Mon, 12 Oct 2015 16:32:42 +1300
Message-ID: <561B29DA.9050101@gna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 12 05:32:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlTr5-0006ni-F8
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 05:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbbJLDcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2015 23:32:50 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:34027 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815AbbJLDct (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2015 23:32:49 -0400
Received: by padhy16 with SMTP id hy16so141340619pad.1
        for <git@vger.kernel.org>; Sun, 11 Oct 2015 20:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=sender:to:from:subject:message-id:date:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=fPobXC0YjLkSsFiPPzCmikNC7NWMrESG94xNDBqbVNg=;
        b=rXUAaUXJ75fAPtU/HLXDVrtfVqPmWfVKk4R80gtZK/jDWdmw9P/sBsQaRHaivtFyeC
         3S3E4+ZKCVw9l9dIE/FFtIRE53KxCMermZmwYAHR/x49DEcpmnfntFXrc80tfoixEp4R
         /+v6zlk4YFleFC26WuIY/iKF1wCsp7f6frHtLZIaKoTjdzQWsBFIZNMvy4tvPl4JkfSm
         1jNzDsInmSbgB6QW9TYlnqzPBCYaQEKlBAhRHmEmWiILOVQhQ2iGR0dek60T9zj+YXyx
         LixT8cxf91k9+kcwE0cIsXqCpw7nEVXPq3d7D1dApf07TMz8MDvxVSqNFbvBbTDHYjeB
         QJAQ==
X-Received: by 10.66.217.138 with SMTP id oy10mr31439744pac.149.1444620766800;
        Sun, 11 Oct 2015 20:32:46 -0700 (PDT)
Received: from [10.64.40.149] (121-73-22-29.cable.telstraclear.net. [121.73.22.29])
        by smtp.googlemail.com with ESMTPSA id pq4sm15140733pbc.53.2015.10.11.20.32.44
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Oct 2015 20:32:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279360>

Hi git hackers,

I have been scratching my head since quite a few weeks to see if and how 
I could hack git to manage non-software-source-code files. Theses files 
might be text-based (XML, JSON, custom format, ...) but are not intended 
for humans, thus diffing and merging them using standard git features 
doesn't really make sense (and so the whole "pack" stuff seems useless 
as well). These files represent a non-software project developed using a 
graphical SW application. I'm talking here about designing and 
simulating electronic projects, but it could be apply to any sort of 
engineering (mechanical design comes second to me)

I would like to provide support for diffing, merging, branching and 
forking such electronics projects.

I know, that git is not a conventional SCM software, and as such doesn't 
rely on incremental diff (like CVS, SVN, ...), but...

My graphical software uses a document/command based approach, that is, 
it doesn't directly transform user interaction into graphical changes, 
instead graphical tools generates commands that are then executed on a 
document, which once completed cause the graphical view to update it's 
content.

So far, in my context, a document is simply a tree of objects, the 
lowest commands available are:
- Insert an object in the tree.
- Remove an object from the tree.
- Modify an object property.
All higher level commands are build in term of the above basic commands.

This is, IMHO, an "interesting" feature in the context of traditional 
SCMs. Instead of storing incremental diff, I could store incremental 
commands (I know it would be dead slow, but it would definitely works)

Since git is simply a "content addressable" file system, I can (using 
plumbing commands) create my own system to store my machine-readable 
project: a tree of documents, documents being themselves tree of 
objects. This fit pretty well with git commit, tree and blob objects.

I could even store a serialised command stack (as a tree of command 
objects, again git fits very well here) along with a commit. This would 
represent the set of operations (I call this a document transaction) to 
transform the git document tree associated with the previous commit into 
the git document tree associated with the current commit.

I feel very confident that I could create wrappers around git plumbing 
commands to implement my 3 basics document commands (that would work on 
the index):
mygit insert-object <document> <object-id>
mygit remove-object <document> <object-id>
mygit change-object <document> <object-id> <property-id> <property-value>
Of course, for this to work "mygit" needs to be aware of the low-level 
file format (XML, JSON, ...), but "mygit" doesn't need to know how to 
interpret the whole document.
Storing my document transactions in git would definitely help with 
merging (automatic or manual) and diffing, since document transaction 
would have some extra meta-data that tells what the user really did and 
why it did it, hence giving hints to the algorithm or the end user on 
how to solve a merge conflict for example.

Now, from there, I don't know what would be the best approach for 
diffing and merging, should I completely replace the git pack, diff and 
merge feature? Should I rely on my concept of command and document 
transaction? Maybe I should keep the pack feature and simply implement 
diff and merge using "clever" algorithm? (Just by looking at 2 versions 
of a document, the algorithm is able to detect what was the purpose of 
the change and replay it on top of another document version)

I'm pretty sure I'm not the first person to investigate into this, I 
would be glad if anyone could provide feedback from their own 
experience, advice on how to move next or simply provides criticism or 
points out to literature or existing projects.

Thanks,
Chris
