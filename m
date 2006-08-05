From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Git files data formats documentation
Date: Fri, 04 Aug 2006 22:39:25 -0700
Message-ID: <44D42F0D.3040707@gmail.com>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080705040702010403050202"
X-From: git-owner@vger.kernel.org Sat Aug 05 07:39:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9Eso-0007Sr-Qz
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 07:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbWHEFjb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 01:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932626AbWHEFjb
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 01:39:31 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:30411 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932624AbWHEFj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 01:39:29 -0400
Received: by py-out-1112.google.com with SMTP id z74so896239pyg
        for <git@vger.kernel.org>; Fri, 04 Aug 2006 22:39:28 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:content-type;
        b=Lel7EQdFjLC+MQgZMNbv2B1h44JDmJzEaC35VfAUovNtc1vnviUJto9V4OLWRVP+lw5du/4JBh8urdxKqTmeUW177rOo/A+yavrAHScjbPn6vUrFhtJey1lw3WEmg6Kakz0UD2YhLmsJwSSX5Ss5XfrBEuCbbWfwJh1+Cki22P8=
Received: by 10.35.113.12 with SMTP id q12mr6550215pym;
        Fri, 04 Aug 2006 22:39:28 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.32.187.210])
        by mx.gmail.com with ESMTP id 14sm1468643nzp.2006.08.04.22.39.26;
        Fri, 04 Aug 2006 22:39:27 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24885>

This is a multi-part message in MIME format.
--------------080705040702010403050202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This information may be useful for reading and writing the various Git 
files.

--------------080705040702010403050202
Content-Type: text/plain;
 name="dataformats.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dataformats.txt"

Git files data formats
======================

OBJECTS
-------
# The object ID, or "name", of an object is
#	_sha-1_digest_( <OBJECT_HEADER> <object_CONTENTS> ).

<BLOB>
	:	_deflate_( <OBJECT_HEADER> <BLOB_CONTENTS> )
	|	<COMPACT_OBJECT_HEADER> _deflate_( <BLOB_CONTENTS> )
	;

<BLOB_CONTENTS>
	:	<DATA>
	;

<TREE>
	:	_deflate_( <OBJECT_HEADER> <TREE_CONTENTS> )
	|	<COMPACT_OBJECT_HEADER> _deflate_( <TREE_CONTENTS> )
	;

<TREE_CONTENTS>
	:	<TREE_ENTRIES>
	;

<TREE_ENTRIES>
	# Tree entries are sorted by the byte sequence that comprises
	# the entry name.
	:	( <TREE_ENTRY> )*
	;

<TREE_ENTRY>
	# The type of the object referenced MUST be appropriate for
	# the mode. Regular files and symbolic links reference a BLOB
	# and directories reference a TREE.
	:	<OCTAL_MODE> <SP> <NAME> <NUL> <BINARY_OBJ_ID>
	;

<COMMIT>
	:	_deflate_( <OBJECT_HEADER> <COMMIT_CONTENTS> )
	|	<COMPACT_OBJECT_HEADER> _deflate_( <COMMIT_CONTENTS> )
	;

<COMMIT_CONTENTS>
	:	"tree" <SP> <HEX_OBJ_ID> <LF>
		( "parent" <SP> <HEX_OBJ_ID> <LF> )*
		"author" <SP>
			<SAFE_NAME> <SP>
			<LT> <SAFE_EMAIL> <GT> <SP>
			<GIT_DATE> <LF>
		"committer" <SP>
			<SAFE_NAME> <SP>
			<LT> <SAFE_EMAIL> <GT> <SP>
			<GIT_DATE> <LF>
		<LF>
		<DATA>
	;

<TAG>
	:	_deflate_( <OBJECT_HEADER> <TAG_CONTENTS> )
	|	<COMPACT_OBJECT_HEADER> _deflate_( <TAG_CONTENTS> )
	;

<TAG_CONTENTS>
	:	"object" <SP> <HEX_OBJ_ID> <LF>
		"type" <SP> <NONTAG_OBJ_TYPE> <LF>
		"tag" <SP> <TAG_NAME> <LF>
		<LF>
		<DATA>
	;

<OBJECT_HEADER>
	:	<OBJ_TYPE> <SP> <DECIMAL_LENGTH> <NUL>
	;

<COMPACT_OBJECT_HEADER>
	# The object type DELTA_ENCODED is not valid in a
	# <COMPACT_OBJECT_HEADER>.
	:	<TYPE_AND_BASE128_SIZE>
	;

<DATA>
	# Uninterpreted sequence of bytes.
	;

<OCTAL_MODE>
	# Octal encoding, without prefix, of the file system object
	# type and permission bits. The bit layout is according to the
	# POSIX standard, with only regular files, directories, and
	# symbolic links permitted. The actual permission bits are
	# all zero except for regular files. The only permission bit
	# of any consequence to Git is the owner executable bit. By
	# default, the permission bits for files will be either 0644
	# or 0755, depending on the owner executable bit.
	;

<NAME>
	# Sequence of bytes not containing the ASCII character byte
	# value NUL (0x00).
	;

<BINARY_OBJ_ID>
	# The object ID of the referenced object.
	;

<HEX_OBJ_ID>
	# Hexidecimal encoding (lower case) of the <BINARY_OBJ_ID>.
	;

<SAFE_NAME>
	:	<SAFE_STRING> 
	;

<SAFE_EMAIL>
	:	<SAFE_STRING>
	;

<SAFE_STRING>
	# A sequence of bytes not containing the ASCII character byte
	# values NUL (0x00), LF (0x0a), '<' (0c3c), or '>' (0x3e).
	#
	# The sequence may not begin or end with any bytes with the
	# following ASCII character byte values: SPACE (0x20),
	# '.' (0x2e), ',' (0x2c), ':' (0x3a), ';' (0x3b), '<' (0x3c),
	# '>' (0x3e), '"' (0x22), "'" (0x27).
	;

<GIT_DATE>
	:	<SECONDS> <SP> <TZ_OFFSET>
	;

<SECONDS>
	# Base 10, ASCII encoding of the number of seconds since 12:00
	# midnight January 1, 1970, UTC without accounting for leap
	# seconds, and without leading zeros.
	;

<TZ_OFFSET>
	# Signed offset of time zone from UTC.
	:	<TZ_OFFSET_SIGN> <TZ_OFFSET_HOURS> <TZ_OFFSET_MIN>
	;

<TZ_OFFSET_SIGN>
	:	"+"
	|	"-"
	;

<TZ_OFFSET_HOURS>
	:	<DIGIT> <DIGIT>
	;

<TZ_OFFSET_MIN>
	# Valid values are "00" to "59" inclusive.
	:	<DIGIT> <DIGIT>
	;

<DIGIT>
	# ASCII decimal digit.
	;

<NONTAG_OBJ_TYPE>
	:	"BLOB"
	|	"TREE"
	|	"COMMIT"
	;

<OBJ_TYPE>
	:	<NONTAG_OBJ_TYPE>
	|	"TAG"
	;

<DECIMAL_LENGTH>
	# Base 10, ASCII encoding of the byte length of the object
	# contents, without leading zeros. The length value does not
	# include the length of the <OBJECT_HEADER>.
	:	( <DIGIT> )+
	;

<SP>
	# ASCII SPACE (0x20) character.
	;

<NUL>
	# ASCII NUL (0x00) character.
	;

<LF>
	# ASCII LF (0x0a) "line feed" character.
	;


PACK FILE
---------
# The name of a pack file is "pack-${PACK_ID}.pack", where ${PACK_ID}
# is the hexidecimal encoding (lower case) of the SHA-1 digest of the
# sorted list of binary object IDs in the pack file without a separator
# between the object IDs. Initially, the ${PACK_ID} for a pack was not
# defined, making the value effectively random.

<PACK_FILE>
	:	<PACK_FILE_CONTENTS> <PACK_FILE_CHECKSUM>
	;

<PACK_FILE_CONTENTS>
	:	"PACK" <PACK_VERSION> <PACK_OBJECT_COUNT>
		( <PACKED_OBJECT_HEADER> <PACKED_OBJECT_DATA> )*
		<PACK_FILE_CHECKSUM>
	;

<PACK_VERSION>
	# 32 bit, network byte order, binary integer indicating which
	# version of the pack file format was used to create the pack
	# file.
	;

<PACK_OBJECT_COUNT>
	# 32 bit, network byte order, binary integer containg the
	# number of objects encoded in the pack file.
	;

<PACK_FILE_CHECKSUM>
	:	_sha-1_digest_( <PACK_FILE_CONTENTS> )
	;


<PACKED_OBJECT_HEADER>
	# If the object type is not a DELTA_ENCODED object, the packed
	# object data that follows is the deflated byte sequence of the
	# object without the Git object header. The length value is the
	# byte count of the inflated byte sequence of the object.
	#
	# If the object type is a DELTA_ENCODED object, what follows is
	# the ID of the base object and the deflated delta data to
	# transform the base object into the target object. The type of
	# the target object is the same as that of the base object and
	# the length value is the byte count of the inflated delta
	# data. The base object may also be DELTA_ENCODED but cyclic
	# base object chains are not permitted and the pack file MUST
	# contain all base objects.
	:	<TYPE_AND_BASE128_SIZE>
	;

<TYPE_AND_BASE128_SIZE>
	# A compact, variable length, encoding of the packed object
	# length and type. The first byte is comprised of 3 fields
	# (where bit 0 is the least significant bit in a byte):
	#	bit 7:		more flag
	#	bits 6-4:	object type
	#	bits 3-0:	least significant bits of the object
	#			length.
	# If the more flag is set, the next byte contains more object
	# length bits.
	# The object types corresponding to the object type bits are:
	#	6 5 4
	#	- - -
	#	0 0 0	invalid: Reserved
	#	0 0 1	COMMIT object
	#	0 1 0	TREE object
	#	0 1 1	BLOB object
	#	1 0 0	TAG object
	#	1 0 1	invalid: Reserved
	#	1 1 0	invalid: Reserved
	#	1 1 1	DELTA_ENCODED object
	#
	# If the more flag was set, the next byte will have more length
	# bits and will be comprised to 2 fields:
	#	bit 7:		more flag
	#	bits 6-0:	7 additional, more significant, bits of
	#			the object length
	# If the more flag is set, the next byte contains more object
	# length bits using the same encoding.
	;

<PACKED_OBJECT_DATA>
	:	_deflate_( <DATA> )
	|	<BINARY_OBJ_ID> _deflate_( <DELTA_DATA> )
	;

<DELTA_DATA>
	# Size of the base object encoded as a base 128 number, least
	# significant bits first, using bit 7 (the most significant
	# bit) of each byte to indicate that more bits follow.
	#
	# Size of the result object encoded as a base 128 number, using
	# the same method as used for the base object size.
	#
	# There will then be a sequence of delta hunks.
	# Zero as the value of the first byte of a hunk in reserved.
	#
	# If bit 7 of the first byte of a delta hunk is not set, the
	# hunk is an "insert" hunk and bits 0-6 specify the number of
	# bytes to append to the output buffer from the hunk.
	#
	# If bit 7 of the first byte of a delta hunk is set, the hunk
	# is a "copy" hunk and bits 0-6 specify how the remaining
	# bytes in the hunk make up the base offset and length for the
	# copy. The following C code demonstrate how to determine the
	# base offset and length for the copy:
	#
	#	/* -  -  -  -  -  -  -  -  -  -  -  - *\
	#	 | This reflects version 3 pack files |
	#	\* -  -  -  -  -  -  -  -  -  -  -  - */
	#
	#	byte *data = delta_hunk_start
	#	opcode = *data++
	#	off_t copy_offset= 0;
	#	size_t copy_length = 0;
	#
	#	for (shift=i=0; i<4; i++) {
	#		if (opcode & 0x01) {
	#			copy_offset |= (*data++)<<shift;
	#			}
	#		opcode >>= 1;
	#		shift += 8;
	#		}
	#
	#	for (shift=i=0; i<3; i++) {
	#		if (opcode & 0x01) {
	#			copy_length |= (*data++)<<shift;
	#			}
	#		opcode >>= 1;
	#		shift += 8;
	#		}
	#
	#	if (!copy_length) {
	#		copy_length = 1<<16;
	#		}
	#
	# For version 2 pack files, the size of a copy is limited to
	# 64K bytes or less and bit 6 of the opcode byte is set if the
	# source of the copy is from the buffer of the result object
	# instead of the the base object.
	#
	# It's unknown if any version 2 pack files were created with
	# bit 6 set in the opcode byte; however, the change that added
	# support for version 3 pack files removed the code that would
	# change the copy source to the result buffer.
	#
	#	/* -  -  -  -  -  -  -  -  -  -  -  - *\
	#	 | This reflects version 2 pack files |
	#	\* -  -  -  -  -  -  -  -  -  -  -  - */
	#
	#	byte *data = delta_hunk_start
	#	opcode = *data++
	#	off_t copy_offset= 0;
	#	size_t copy_length = 0;
	#
	#	for (shift=i=0; i<4; i++) {
	#		if (opcode & 0x01) {
	#			copy_offset |= (*data++)<<shift;
	#			}
	#		opcode >>= 1;
	#		shift += 8;
	#		}
	#
	#	for (shift=i=0; i<2; i++) {
	#		if (opcode & 0x01) {
	#			copy_length |= (*data++)<<shift;
	#			}
	#		opcode >>= 1;
	#		shift += 8;
	#		}
	#
	#	if (!copy_length) {
	#		copy_length = 1<<16;
	#		}
	#
	#	copy_from_result = opcode & 0x01
	#
	;


PACK INDEX
----------
# The name of a pack file index is "pack-${PACK_ID}.idx", where
# ${PACK_ID} is the hexidecimal encoding (lower case) of the SHA-1
# digest of the sorted list of binary object IDs in the pack file
# without a separator between the object IDs. Initially, the ${PACK_ID}
# for a pack was not defined, making the value effectively random.

<PACK_INDEX>
	:	<PACK_INDEX_CONTENTS> <PACK_INDEX_CHECKSUM>
	;

<PACK_INDEX_CONTENTS>
	:	( <INDEX_PARTIAL_COUNT> ){256}
		( <PACK_OBJECT_OFFSET> <BINARY_OBJ_ID> )*
		<PACK_FILE_CHECKSUM>
	;

<INDEX_PARTIAL_COUNT>
	# 32 bit, network byte order, binary integer of the count of
	# objects in the pack file with the first byte of the object
	# ID less than or equal to the index of the count, starting
	# from zero.
	;

<PACK_OBJECT_OFFSET>
	# 32 bit, network byte order, binary integer giving the offset,
	# in bytes from the begining of the pack file, where the
	# encoding of the object starts.
	;

<PACK_INDEX_CHECKSUM>
	:	_sha-1_digest_( <PACK_INDEX_CONTENTS> )
	;


INDEX FILE (CACHE)
------------------

<INDEX_FILE>
	:	<INDEX_FILE_FORMAT_V1>
	|	<INDEX_FILE_FORMAT_V2>
	;

<INDEX_FILE_FORMAT_V1>
	# This format is no longer supported.
	:	<INDEX_HEADER> <INDEX_CHECKSUM> <INDEX_CONTENTS>
	;

<INDEX_FILE_FORMAT_V2>
	:	<INDEX_HEADER> <EXTENDED_INDEX_CONTENTS> <EXTENED_CHECKSUM>
	;

<INDEX_HEADER>
	:	"DIRC" <INDEX_FILE_VERSION> <INDEX_ENTRY_COUNT>
	;

<INDEX_FILE_VERSION>
	# 32 bit, network byte order, binary integer indicating which
	# version of the index file format was used to create the
	# index file.
	;

<INDEX_ENTRY_COUNT>
	# 32 bit, network byte order, binary integer containg the
	# number of index entries in the index file.
	;

<EXTENDED_CHECKSUM>
	:	_sha-1_digest_( <EXTENDED_INDEX_CONTENTS> )
	;

<INDEX_CHECKSUM>
	:	_sha-1_digest_( <INDEX_CONTENTS> )
	;

<INDEX_CONTENTS>
	:	( <INDEX_ENTRY> )*
	;

<EXTENDED_INDEX_CONTENTS>
	:	<INDEX_CONTENTS> <INDEX_CONTENTS_EXTENSIONS>
	;

<INDEX_ENTRY>
	:	<INDEX_ENTRY_STAT_INFO>
		<ENTRY_ID>
		<ENTRY_FLAGS>
		<ENTRY_NAME>
	;

<INDEX_ENTRY_STAT_INFO>
	# These fields are used as a part of a heuristic to determine
	# if the file system entity associated with this entry has
	# changed. The names are very *nix centric but the exact
	# contents of each field have no meaning to Git, besides exact
	# match, except for the <ENTRY_MODE> and <ENTRY_SIZE> fields.
	:	<ENTRY_CTIME>
		<ENTRY_MTIME>
		<ENTRY_DEV>
		<ENTRY_INODE>
		<ENTRY_MODE>
		<ENTRY_UID>
		<ENTRY_GID>
		<ENTRY_SIZE>
	;

<ENTRY_CTIME>
	# The timestamp of the last status change of the associated
	# file system entity.
	:	<ENTRY_TIME>
	;

<ENTRY_MTIME>
	# The timestamp of the last modification of the associated
	# file system entity.
	:	<ENTRY_TIME>
	;

<ENTRY_TIME>
	:	<TIME_LSB32> <TIME_NSEC>
	;

<TIME_LSB32>
	# 32 bit, network byte order, binary integer containg the lower
	# 32 bits of the entry (file or symbolic link) timestamp.
	;

<TIME_NSEC>
	# 32 bit, network byte order, binary integer containg the lower
	# 32 bits of the entry (file or symbolic link) more precise
	# timestamp, if available.
	;

<ENTRY_DEV>
	# 32 bit, network byte order, binary integer containg the lower
	# 32 bits of the entry (file or symbolic link) file system
	# device identifier. Use of this field is a compile time
	# option.
	;

<ENTRY_INODE>
	# 32 bit, network byte order, binary integer containg the lower
	# 32 bits of the entry (file or symbolic link) inode number, or
	# equivalent.
	;

<ENTRY_MODE>
	# 32 bit, network byte order, binary integer containg the lower
	# 32 bits of the entry (file or symbolic link) file system
	# entity type and permissions.
	;

<ENTRY_UID>
	# 32 bit, network byte order, binary integer containg the lower
	# 32 bits of the entry (file or symbolic link) file system
	# entity owner identifier.
	;

<ENTRY_GID>
	# 32 bit, network byte order, binary integer containg the lower
	# 32 bits of the entry (file or symbolic link) file system
	# entity group identifier, or equivalent.
	;

<ENTRY_SIZE>
	# 32 bit, network byte order, binary integer containg the lower
	# 32 bits of the entry (file or symbolic link) size.
	;

<ENTRY_ID>
	# Object ID of the of the file system entity contents.
	;

<ENTRY_FLAGS>
	# 16 bit, network byte order, binary integer.
	#	bits 15-14	Reserved
	#	bits 13-12	Entry stage
	#	bits 11-0	Name byte length
	#
	# See git-read-tree(1) for a description of how the stage
	# field is used.
	;

<ENTRY_NAME>
	# File system entity name. Path is normalized and relative to
	# the working directory.
	;

<INDEX_CONTENTS_EXTENSIONS>
	:	( <INDEX_EXTENSION> )*
	;

<INDEX_EXTENSION>
	:	<INDEX_EXTENSION_HEADER>
		<INDEX_EXTENSION_DATA>
	;

<INDEX_EXTENSION_HEADER>
	:	<INDEX_EXTENSION_NAME> <INDEX_EXTENSION_DATA_SIZE>
	;

<INDEX_EXTENSION_NAME>
	# 4 byte sequence identifying how the <INDEX_EXTENSION_DATA>
	# should be interpreted. The first byte having a value greater
	# than or equal to the ASCII character 'A' (0x41) and less than
	# or equal to the ASCII character 'Z' (0x5a).
	;

<INDEX_EXTENSION_DATA_SIZE>
	# 32 bit, network byte order, binary integer containg the
	# length of the <INDEX_EXTENSION_DATA> byte sequence.
	;

<INDEX_EXTENSION_DATA>
	# Sequence of bytes.
	;



--------------080705040702010403050202--
