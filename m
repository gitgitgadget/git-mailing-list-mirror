From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Index format v5
Date: Fri, 11 May 2012 19:12:30 +0200
Message-ID: <20120511171230.GA2107@tgummerer>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
 <4FA7E703.7040408@alum.mit.edu>
 <20120508141137.GA3937@tgummerer.surfnet.iacbox>
 <4FAA2CAF.3040408@alum.mit.edu>
 <20120510121911.GB98491@tgummerer>
 <4FAC0633.90809@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, gitster@pobox.com,
	peff@peff.net, spearce@spearce.org, davidbarr@google.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri May 11 19:12:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SStOV-0005A8-Mk
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 19:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760836Ab2EKRMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 13:12:37 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:64594 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760706Ab2EKRMg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 13:12:36 -0400
Received: by wgbdr13 with SMTP id dr13so2721800wgb.1
        for <git@vger.kernel.org>; Fri, 11 May 2012 10:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=X7JR3hNB2m0SuRNvWxhOzEEQ4WwCPVxbLvzbFjGrZE0=;
        b=w6OZJdZYevSvsjaPe8F7QK/P1/1Zl+zB8FhBasTMGI4lKjJJjqIwCFZ5iELMkSw3ey
         1FVo01pu3PsI3d9pkVesmuVL9Cp0mer8dCQsFSSKTZU6OCwAbbAoOzpf45RrDgy9XO23
         dqRZCg3/TFVOn4ttq54B8Pdm90W9A/Uv48MdS0FKT1HszbXn93cwTrBrXywUz+g9E9fi
         I8qeFHIjBQNxPGjQomuAEbZwhFbu+JpexhVEW7OzaDVh5P+brniIZkEMKluIgA1KOLWq
         kwLfEmUQUKiWjPoEN3alI6sN9mBOXmGGO1i9BNa8gKi4j/z5diXMIgLomKDaE7ZjEQ3Z
         dlqg==
Received: by 10.216.198.14 with SMTP id u14mr1981882wen.12.1336756355008;
        Fri, 11 May 2012 10:12:35 -0700 (PDT)
Received: from localhost (host186-197-dynamic.8-87-r.retail.telecomitalia.it. [87.8.197.186])
        by mx.google.com with ESMTPS id b3sm11785917wib.4.2012.05.11.10.12.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 11 May 2012 10:12:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FAC0633.90809@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197680>

On 05/10, Michael Haggerty wrote:
> On 05/10/2012 02:19 PM, Thomas Gummerer wrote:
> >== Flat loading
> >
> >Since internally git expects and works with lexicografic ordering,
> >a simple linear scan throught the subdirectories doesn't give
> >the right internal sorting. To achieve the right internal sorting
> >the loading will be done in the following way:
> >
> >The data structure is a stack of queues, to allow continous reading
> >of the file.
> >
> >s ->  queue1
> >t ->  queue2
> >a ->  queue3
> >c ->  queue4
> >k ->  queue5
> >
> >dirs = read_all_directories
> >
> >foreach dir in dirs do
> >     file = read_next_file
> >
> >     while element_on_top_of_stack.first_element<  nextdir
> >         indexentries.append(dequeue(element_on_top_of_stack))
> >         if element_on_top_of_stack == emtpy:
> >             remove_element_on_top_of_stack
> >
> >     if file[filename]<  nextdir
> >         indexentries.append(file)
> >     else
> >         queue.add(file)
> >         foreach f in rest_of_files_in_directory:
> >             queue.add(f)
> >         stack.push(queue)
> >
> >foreach queue in stack:
> >     foreach entry in queue:
> >         indexentry.append(entry)
> 
> 1. It seems to me that the first time that a file with a filename
> before nextdir is encountered, the reading of the directory
> containing the file will be terminated.  This would, for example, be
> the case for any directory that contains multiple files but no
> subdirectories.
> 
> 2. There is still a lot that is unnecessarily obscure.  For example,
> I suppose (but you don't say) that "rest_of_files_in_directory"
> means to read the files at that moment.  It would be more explicit
> (and no more verbose) to write
> 
>     while (f = read_next_file()) != NULL:
>         queue.add(f)
> 
> 3. You don't cover corner cases, like when read_next_file() is
> called but there are no files left in the directory, or when there
> is no nextdir (which itself is not defined).  OK, this pseudocode is
> only meant to be illustrative, so I guess we can wait until your
> real implementation to see such details.  On the other hand, you
> probably want to get all the details straight in pseudocode or
> Python before you start translating it into C.
> 
> 4. I think the algorithm would be easier to understand and implement
> if it were written recursively.  The call stack would replace your
> explicit stack (but you would still need one queue per directory
> level).  A key observation is that when "nextdir" precedes the next
> file, then all of the files in subdirectories of nextdir do as well.
> Thus an obvious recursion would be to call a function like
> read_all_files_under_dir(indexentries, dirs, dirindex) at this
> point, which would consume all of the directories that are
> subdirectories of dirs[dirindex] (i.e., all directories whose names
> have the string dirs[dirindex] as a prefix).  Using this method
> would mean that there is no need to compare each file under
> dirs[dirindex] against the next file in the outer directory.
> 
> Michael

Thanks for your feedback! To get clearer code I've now written a
working reader for the v5 index format in Python. The full reader
would probably be to long for the mailing list, but here is the
interesting part:


def readfiles(directories, dirnr, entries):
    global filedata
    f.seek(directories[dirnr]["foffset"])
    offset = struct.unpack("!I", fread(4))[0]
    f.seek(offset)
    filedata = list()
    queue = list()
    i = 0
    while i < directories[dirnr]["nfiles"]:
        filedata.append(struct.pack("!I", f.tell()))
        filename = ""
        byte = fread(1)
        while byte != '\0':
            filename += byte
            byte = fread(1)

        data = struct.unpack("!HHIII", fread(16))
        objhash = fread(20)
        readcrc = struct.pack("!i", binascii.crc32("".join(filedata)))
        crc = f.read(4)
        if readcrc != crc:
            print "Wrong CRC: " + filename
        filedata = list()

        i += 1

        queue.append(dict({"name": directories[dirnr]["pathname"] + filename, "flags": data[0], "mode": data[1], "mtimes": data[2], "mtimens": data[3], "statcrc": data[4], "objhash": binascii.hexlify(objhash)}))

    if len(directories) > dirnr:
        i = 0
        while i < len(queue):
            if len(directories) - 1 > dirnr and queue[i]["name"] > directories[dirnr + 1]["pathname"]:
                entries, dirnr = readfiles(directories, dirnr + 1, entries)
            else:
                entries.append(queue[i])
                i += 1
        return entries, dirnr

The full reader can be found here:
https://github.com/tgummerer/git/blob/pythonprototype/git-read-index-v5.py

-- 
Thomas
